import 'connector.dart';
import '../../utils/format_url.dart';

Future<dynamic> getCategory(
  Map<String, dynamic> parameters,
  RequestOptions requestOptions,
) async {
  final url = formatUrl("/api/category", parameters);
  return await connector.get(url, options: requestOptions);
}
