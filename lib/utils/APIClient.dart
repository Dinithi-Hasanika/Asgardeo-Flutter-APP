import 'package:http/http.dart' as http;

class APIClient {

  Future<http.Response> httpGet(String url, String? accessToken) {
    final result = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    return result;
  }
}