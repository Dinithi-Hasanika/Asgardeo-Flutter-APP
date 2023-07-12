import 'package:flutter_appauth/flutter_appauth.dart';
import '../configs/configs.dart';
import '../configs/endPointUrls.dart';
import 'AuthConstants.dart' as Constants;

class Auth{

Future<AuthorizationTokenResponse?> authorize(flutterAppAuth) async {

  final AuthorizationTokenResponse? result = await flutterAppAuth.authorizeAndExchangeCode(
    AuthorizationTokenRequest(
      clientId,
      redirectUrl,
      discoveryUrl: discoveryUrl,
      promptValues: [Constants.login],
      scopes: [Constants.openidScope, Constants.profile, Constants.address, Constants.phone, Constants.internalLoginScope],
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