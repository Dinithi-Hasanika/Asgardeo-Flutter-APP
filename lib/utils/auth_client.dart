import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:provider/provider.dart';

import '../configs/configs.dart';
import '../configs/end_point_urls.dart';
import '../constants/app_constants.dart';
import '../providers/page.dart';
import '../providers/user_session.dart';

const FlutterAppAuth flutterAppAuth = FlutterAppAuth();

class AuthClient{

loginFunction(BuildContext context) async{
  try{
    final AuthorizationTokenResponse? result = await flutterAppAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectUrl,
        discoveryUrl: discoveryUrl,
        promptValues: [AuthConstants.login],
        scopes: [AuthConstants.openidScope, AuthConstants.profile, AuthConstants.address, AuthConstants.phone, AuthConstants.internalLoginScope],
      ),
    );
    if(context.mounted) {
      context.read<CurrentPage>().setPageAndUserStatus(AppConstants.homePage, true);
      context.read<UserSession>().loginSuccessfulFunction(result?.accessToken, result?.idToken, result?.refreshToken);
    }
  }catch(e, s){
    print('Error while login to the system: $e - stack: $s');
    context.read<CurrentPage>().setPageAndUserStatus(AppConstants.firstPage, false);
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

  logOutUser(BuildContext context) async{
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
      context.read<CurrentPage>().setPageAndUserStatus(AppConstants.firstPage, false);
      //TODO: clear user sessions
    }
  }catch(e){
    print(e);
    loginFunction(context);
  }
  }

}
