import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:provider/provider.dart';
import '../configs/configs.dart';
import '../configs/endPointUrls.dart';
import '../providers/page.dart';
import '../providers/user_session.dart';
import 'AuthConstants.dart' as Constants;
import 'package:asgardeo_flutter_app/constants.dart';

final FlutterAppAuth flutterAppAuth = FlutterAppAuth();

class AuthClient{

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

loginFunction(BuildContext context) async{
  try{
    final AuthorizationTokenResponse? result = await flutterAppAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectUrl,
        discoveryUrl: discoveryUrl,
        promptValues: [Constants.login],
        scopes: [Constants.openidScope, Constants.profile, Constants.address, Constants.phone, Constants.internalLoginScope],
      ),
    );
    if(context.mounted) {
      context.read<CurrentPage>().setPageAndUserStatus(homePage, true);
      context.read<UserSession>().loginSuccessfulFunction(result?.accessToken, result?.idToken, result?.refreshToken);
    }
  }catch(e, s){
    print('Error while login to the system: $e - stack: $s');
    context.read<CurrentPage>().setPageAndUserStatus(firstPage, false);
  }
}

renewAccessToken(BuildContext context) async {
  try{
    final TokenResponse? tokenResponse = await flutterAppAuth.token(
        TokenRequest(clientId,
            redirectUrl,
            grantType: GrantType.refreshToken,
            refreshToken: context.read<UserSession>().refreshToken,
            discoveryUrl: discoveryUrl
        )
    );
    if(context.mounted) {
      context.read<UserSession>().loginSuccessfulFunction(tokenResponse?.accessToken, tokenResponse?.idToken, tokenResponse?.refreshToken);
    }
  }catch(e){
    print(e);
    loginFunction(context);
  }
}

  logOutUser2(BuildContext context) async{
  try {
    await flutterAppAuth.endSession(
      EndSessionRequest(
        idTokenHint: context
            .read<UserSession>()
            .idToken,
        postLogoutRedirectUrl: redirectUrl,
        discoveryUrl: discoveryUrl,
      ),
    );

    if (context.mounted) {
      context.read<CurrentPage>().setPageAndUserStatus(firstPage, false);
      //TODO: clear user sessions
    }
  }catch(e){
    print(e);
    loginFunction(context);
  }
  }

}
