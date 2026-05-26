import 'connector.dart';
import '../../utils/format_url.dart';

Future<dynamic> getCategory(
  Map<String, dynamic> parameters, {
  RequestOptions options = const RequestOptions(),
}) async {
  final url = formatUrl("/api/category", parameters);
  return await connector.get(url, options: options);
}
