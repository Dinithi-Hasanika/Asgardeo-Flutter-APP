import 'package:flutter_appauth/flutter_appauth.dart';
import '../configs/configs.dart';

const discoveryUrl =
    'https://api.asgardeo.io/t/$organizationName/oauth2/token/.well-known/openid-configuration';
class Auth{

Future<AuthorizationTokenResponse?> authorize(flutterAppAuth) async {

  final AuthorizationTokenResponse? result = await flutterAppAuth.authorizeAndExchangeCode(
    AuthorizationTokenRequest(
      clientId,
      redirectUrl,
      discoveryUrl: discoveryUrl,
      promptValues: ['login'],
      scopes: ['openid', 'profile', 'address', 'phone', 'internal_login'],
    ),
  );
  return result;
}

Future<TokenResponse?> refreshToken(flutterAppAuth, refreshToken) async{
  final TokenResponse? tokenResponse = await flutterAppAuth.token(
      TokenRequest(clientId,
          redirectUrl,
          grantType: GrantType.refreshToken,
          refreshToken: refreshToken,
          discoveryUrl: discoveryUrl
      )
  );
  return tokenResponse;
}
}