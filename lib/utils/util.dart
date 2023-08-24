import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/user_session.dart';

class Util{

  Map generateUpdateRequestBody(firstName, lastName, country){
    Map data = {
      "schemas": [
        "urn:ietf:params:scim:api:messages:2.0:PatchOp"
      ],
      "Operations": [
        {
          "op": "replace",
          "value": {
            "name":{
              "givenName": "$firstName",
              "familyName": "$lastName"
            },
            "urn:scim:wso2:schema":{
              "country":"$country"
            }
          }
        }
      ]
    };
    return data ;
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  String getUsername(BuildContext context){
    try {
      var profile = parseJwt(context
          .read<UserSession>()
          .idToken);
      return profile['username'];
    }catch(e){
      return "";
    }

  }

}