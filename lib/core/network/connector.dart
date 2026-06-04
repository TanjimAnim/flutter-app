import 'dart:convert';

import 'package:dio/dio.dart' as dio;

typedef ResponseHandler<T> =
    Future<T> Function(dio.Response response, RequestOptions options);
typedef VoidHandler = Future<void> Function();
typedef NetworkErrorHandler = Future<void> Function();

class RequestOptions {
  final Map<String, String>? headers;
  final VoidHandler? onRequestStart;
  final VoidHandler? onRequestEnd;

  final ResponseHandler? handle404;
  final ResponseHandler? handle403;
  final ResponseHandler? handle400;

  final ResponseHandler? handleBadReq;
  final ResponseHandler? handle500;

  final ResponseHandler? successHandler;
  final ResponseHandler? errorHandler;
  final NetworkErrorHandler? onNetworkError;

  final bool externalUrl;
  final String Function(dynamic payload)? encoder;

  final bool removeContentType;

  const RequestOptions({
    this.headers,
    this.onRequestStart,
    this.onRequestEnd,
    this.handle404,
    this.handle403,
    this.handle400,
    this.handleBadReq,
    this.handle500,
    this.successHandler,
    this.errorHandler,
    this.onNetworkError,
    this.externalUrl = false,
    this.encoder,
    this.removeContentType = false,
  });
}

class Connector {
  String baseUrl;
  Map<String, String> headers;

  int onRequestStartDelay;

  VoidHandler? onRequestStart;
  VoidHandler? onRequestEnd;

  ResponseHandler? handle404;
  ResponseHandler? handle403;
  ResponseHandler? handle400;
  ResponseHandler? handleBadReq;
  ResponseHandler? handle500;
  ResponseHandler? successHandler;
  ResponseHandler? errorHandler;
  NetworkErrorHandler? onNetworkError;

  bool _runningRequest = false;
  final dio.Dio _dio = dio.Dio();
  Connector({
    this.baseUrl = '',
    Map<String, String>? headers,
    this.onRequestStartDelay = 0,
  }) : headers = headers ?? {};

  void mergeHeaders(Map<String, String> extra) {
    headers.addAll(extra);
  }

  Future<void> _handleRequestStart(RequestOptions options) async {
    _runningRequest = true;
    if (onRequestStartDelay > 0) {
      await Future.delayed(Duration(milliseconds: onRequestStartDelay));
    }
    if (_runningRequest) {
      await (options.onRequestStart ?? onRequestStart)?.call();
    }
  }

  Future<void> _handleRequestEnd(RequestOptions options) async {
    _runningRequest = false;
    await (options.onRequestStart ?? onRequestStart)?.call();
  }

  Future<dynamic> handleResponse(
    dio.Response response,
    RequestOptions options,
  ) async {
    await _handleRequestEnd(options);
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final handler = options.successHandler ?? successHandler;
      if (handler != null) return handler(response, options);
      return _defaultSuccessHandler(response, options);
    } else {
      final handler = options.errorHandler ?? errorHandler;
      if (handler != null) return handler(response, options);
      return _defaultErrorHandler(response, options);
    }
  }

  Future<dynamic> _defaultSuccessHandler(
    dio.Response response,
    RequestOptions options,
  ) async {
    if (response.data == null) return null;
    return response.data; // already decoded, no jsonDecode needed
  }

  Future<dynamic> _defaultErrorHandler(
    dio.Response response,
    RequestOptions options,
  ) async {
    final status = response.statusCode ?? 0;

    if (status == 404) {
      return await _resolve404(response, options);
    } else if (status == 403) {
      return await _resolve403(response, options);
    } else if (status == 400) {
      return await _resolve400(response, options);
    } else if (status >= 400 && status < 500) {
      return await _resolveBadReq(response, options);
    } else if (status >= 500) {
      return await _resolve500(response, options);
    }
  }

  Future<dynamic> _resolve404(dio.Response res, RequestOptions opts) async {
    if (opts.handle404 != null) return opts.handle404!(res, opts);
    if (opts.handleBadReq != null) return opts.handleBadReq!(res, opts);
    if (handle404 != null) return handle404!(res, opts);
    return _resolveBadReq(res, opts);
  }

  Future<dynamic> _resolve403(dio.Response res, RequestOptions opts) async {
    if (opts.handle403 != null) return opts.handle403!(res, opts);
    if (opts.handleBadReq != null) return opts.handleBadReq!(res, opts);
    if (handle403 != null) return handle403!(res, opts);
    return _resolveBadReq(res, opts);
  }

  Future<dynamic> _resolve400(dio.Response res, RequestOptions opts) async {
    if (opts.handle400 != null) return opts.handle400!(res, opts);
    if (opts.handleBadReq != null) return opts.handleBadReq!(res, opts);
    if (handle400 != null) return handle400!(res, opts);
    return _resolveBadReq(res, opts);
  }

  Future<dynamic> _resolveBadReq(dio.Response res, RequestOptions opts) async {
    if (opts.handleBadReq != null) return opts.handleBadReq!(res, opts);
    if (handleBadReq != null) return handleBadReq!(res, opts);
    // built-in default
    // ignore: avoid_print
    print('Error request: ${res.statusCode}');
    return res;
  }

  Future<void> _resolve500(dio.Response res, RequestOptions opts) async {
    if (opts.handle500 != null) return opts.handle500!(res, opts);
    if (handle500 != null) return handle500!(res, opts);
    // built-in default
    // ignore: avoid_print
    print('Internal Server Error');
  }

  Future<void> _handleNetworkError(RequestOptions options) async {
    final handler = options.onNetworkError ?? onNetworkError;
    if (handler != null) {
      await handler();
    } else {
      // ignore: avoid_print
      print('Network Error');
    }
  }

  // Uri _buildUri(String url, RequestOptions options) {
  //   final resolved = options.externalUrl ? url : joinUrl(baseUrl, url);
  //   return Uri.parse(resolved);
  // }

  String _buildUrl(String url, RequestOptions options) =>
      options.externalUrl ? url : Connector.joinUrl(baseUrl, url);

  Map<String, String> _buildHeaders(RequestOptions options) {
    return {
      'Content-Type': 'application/json',
      ...headers,
      if (options.headers != null) ...options.headers!,
    };
  }

  dio.Options _dioOptions(RequestOptions options) {
    final hdrs = _buildHeaders(options);
    if (options.removeContentType) hdrs.remove('Content-Type');
    return dio.Options(headers: hdrs);
  }

  Future<dynamic> get(
    String url, {
    RequestOptions options = const RequestOptions(),
  }) async {
    await _handleRequestStart(options);
    try {
      final response = await _dio.get(
        _buildUrl(url, options),
        options: _dioOptions(options),
      );
      return handleResponse(response, options);
    } catch (_) {
      await _handleNetworkError(options);
    }
  }

  Future<dynamic> post(
    String url,
    dynamic payload, {
    RequestOptions options = const RequestOptions(),
  }) async {
    await _handleRequestStart(options);

    final hdrs = _buildHeaders(options);
    if (options.removeContentType) hdrs.remove('Content-Type');

    final body = options.encoder != null
        ? options.encoder!(payload)
        : jsonEncode(payload);

    try {
      final response = await _dio.post(
        _buildUrl(url, options),
        data: body,
        options: _dioOptions(options),
      );
      return handleResponse(response, options);
    } catch (_) {
      await _handleNetworkError(options);
    }
  }

  Future<dynamic> put(
    String url,
    dynamic payload, {
    RequestOptions options = const RequestOptions(),
  }) async {
    await _handleRequestStart(options);

    final hdrs = _buildHeaders(options);
    if (options.removeContentType) hdrs.remove('Content-Type');

    final body = options.encoder != null
        ? options.encoder!(payload)
        : jsonEncode(payload);

    try {
      final response = await _dio.put(
        _buildUrl(url, options),
        data: body,
        options: _dioOptions(options),
      );
      return handleResponse(response, options);
    } catch (_) {
      await _handleNetworkError(options);
    }
  }

  Future<dynamic> delete(
    String url, {
    RequestOptions options = const RequestOptions(),
  }) async {
    await _handleRequestStart(options);
    try {
      final response = await _dio.delete(
        _buildUrl(url, options),
        options: _dioOptions(options),
      );
      return handleResponse(response, options);
    } catch (_) {
      await _handleNetworkError(options);
    }
  }

  static String joinUrl(String base, String relative) {
    if (relative.startsWith('dio://') || relative.startsWith('dios://')) {
      return relative; // already absolute
    }

    final baseParts = _removeTrailingSlash(base.split('/'));
    final relParts = _removeLeadingSlash(relative.split('/'));

    final parts = [...baseParts, ...relParts];

    // Resolve . and ..
    final resolved = <String>[];
    for (final part in parts) {
      if (part == '..') {
        if (resolved.isNotEmpty) resolved.removeLast();
      } else if (part != '.') {
        resolved.add(part);
      }
    }
    return resolved.join('/');
  }

  static List<String> _removeTrailingSlash(List<String> parts) {
    final p = List<String>.from(parts);
    while (p.isNotEmpty && p.last.isEmpty) {
      p.removeLast();
    }
    return p;
  }

  static List<String> _removeLeadingSlash(List<String> parts) {
    final p = List<String>.from(parts);
    while (p.isNotEmpty && p.first.isEmpty) {
      p.removeAt(0);
    }
    return p;
  }
}

final connector = Connector();
