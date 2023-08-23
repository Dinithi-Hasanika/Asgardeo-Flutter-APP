import 'dart:convert';

import 'package:asgardeo_flutter_app/providers/user.dart';
import 'package:asgardeo_flutter_app/utils/Auth.dart';
import 'package:asgardeo_flutter_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../configs/configs.dart';
import '../configs/endPointUrls.dart';
import '../constants.dart';
import '../providers/page.dart';
import '../providers/user_session.dart';
import 'http_client.dart';

class APIClient{

  Future<void> getUserProfileData(BuildContext context) async {

    final userInfo = await HTTPClient().httpGet(meEndpoint, context.read<UserSession>().accessToken);

    if (userInfo.statusCode == httpSuccessCode) {
      var profile = jsonDecode(userInfo.body);
      if(context.mounted) {
        context.read<User>().setUserDetails(profile);
        context.read<CurrentPage>().setPageIndex(profilePage);
      }
    }else if (userInfo.statusCode == httpUnauthorizedCode) {
        if(context.mounted) {
          await AuthClient().renewAccessToken(context);
        }
        if(context.mounted) {
          await getUserProfileData(context);
        }

    }
  }

  Future<void> updateUserProfile(firstName, lastName, country, BuildContext context) async {

    Map data = Util().generateUpdateRequestBody(firstName, lastName, country);
    final updatedInfo = await HTTPClient().httpPatch(meEndpoint, context.read<UserSession>().accessToken, data);

    if (updatedInfo.statusCode == httpSuccessCode) {
      var profile = jsonDecode(updatedInfo.body);
      if(context.mounted) {
        context.read<User>().setUserDetails(profile);
        context.read<CurrentPage>().setPageIndex(profilePage);
      }
    }else if (updatedInfo.statusCode == httpUnauthorizedCode) {
      if(context.mounted) {
        await AuthClient().renewAccessToken(context);
      }
      if(context.mounted) {
        await updateUserProfile(firstName, lastName, country, context);
      }
    }
  }

  Future<void> callExternalAPIFunction(BuildContext context) async {

    final externalInfo = await HTTPClient().httpGet(externalAPIEndpoint, context.read<UserSession>().accessToken);

    if (externalInfo.statusCode == httpSuccessCode) {
      if(context.mounted) {
        context.read<CurrentPage>().setExternalAPIPage(externalAPIResponsePage, externalInfo.body);
      }
    }else if (externalInfo.statusCode == httpUnauthorizedCode) {
      if(context.mounted) {
        await AuthClient().renewAccessToken(context);
      }
      if(context.mounted) {
        await callExternalAPIFunction(context);
      }
    }else{
      if(context.mounted) {
        context.read<CurrentPage>().setExternalAPIPage(externalAPIResponsePage, "Cannot Get external API Data!! Please Check Configured external API Endpoint!");
      }
    }
  }

}