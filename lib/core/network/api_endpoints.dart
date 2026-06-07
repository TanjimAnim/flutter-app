import 'connector.dart';
import '../../utils/format_url.dart';

Future<dynamic> getCategory(
  Map<String, dynamic> parameters, {
  RequestOptions options = const RequestOptions(),
}) async {
  final url = formatUrl("/api/category", parameters);
  return await connector.get(url, options: options);
}

Future<dynamic> getCourse(
  Map<String, dynamic> parameters, {
  RequestOptions options = const RequestOptions(),
}) async {
  final url = formatUrl("/api/course", parameters);
  return await connector.get(url, options: options);
}

Future<dynamic> login(
  Map<String, dynamic> payload,
  Map<String, dynamic> parameters, {
  RequestOptions options = const RequestOptions(),
}) async {
  final url = formatUrl("/api/student/login", parameters);
  return await connector.post(url, payload);
}
