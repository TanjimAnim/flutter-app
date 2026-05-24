String objToUrlParams(Map<String, dynamic> obj) {
  final keys = obj.keys.toList();
  if (keys.isEmpty) return '';

  String paramStr = '?';
  final validEntries = <String>[];

  for (final key in keys) {
    final value = obj[key];

    if (value == null || value == false && value is! bool) continue;
    if (value == '' || (value is List && value.isEmpty)) continue;

    String encoded;

    if (value is bool) {
      encoded = '$key=${value ? 1 : 0}';
    } else if (value is List) {
      final joined = value
          .map((i) {
            if (i is String) return i.trim();
            if (i is bool) return i ? '1' : '0';
            return '$i';
          })
          .join(',');
      encoded = '$key=$joined';
    } else {
      encoded = '$key=$value';
    }

    validEntries.add(encoded);
  }

  if (validEntries.isEmpty) return '';
  paramStr += validEntries.join('&');
  return paramStr;
}

String formatUrl(String url, Map<String, dynamic> paramObj) {
  return url + objToUrlParams(paramObj);
}
