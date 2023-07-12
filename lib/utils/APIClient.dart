import 'package:http/http.dart' as http;
import 'dart:convert';

class APIClient {

  Future<http.Response> httpGet(String url, String? accessToken) {
    final result = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    return result;
  }

  Future<http.Response> httPatch(String url, String? accessToken, data){
    final result = http.patch(
      Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken', 'Content-Type': 'application/scim+json'},
        body: json.encode(data)
    );
    return result;
  }
}