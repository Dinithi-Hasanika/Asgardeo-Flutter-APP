import 'package:flutter_appauth/flutter_appauth.dart';
import '../configs/configs.dart';
import '../configs/endPointUrls.dart';

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

logOutUser(flutterAppAuth, idToken) async{
  await flutterAppAuth.endSession(
    EndSessionRequest(
      idTokenHint: idToken,
      postLogoutRedirectUrl: redirectUrl,
      discoveryUrl: discoveryUrl,
    ),
  );
}
}