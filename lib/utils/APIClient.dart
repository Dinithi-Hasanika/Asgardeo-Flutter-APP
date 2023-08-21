import 'package:http/http.dart' as http;
import 'dart:convert';
import 'APIClientConstants.dart' as Constants;

class APIClient {

  Future<http.Response> httpGet(String url, String? accessToken) {
    final result = http.get(
      Uri.parse(url),
      headers: {Constants.authorization: '${Constants.bearer} $accessToken'},
    );
    return result;
  }

  Future<http.Response> httpPatch(String url, String? accessToken, data){
    final result = http.patch(
      Uri.parse(url),
        headers: {Constants.authorization: '${Constants.bearer} $accessToken',
          Constants.contentType: Constants.contentTypeJson},
        body: json.encode(data)
    );
    return result;
  }
}
