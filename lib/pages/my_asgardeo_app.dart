import 'package:asgardeo_flutter_app/constants/strings.dart';
import 'package:asgardeo_flutter_app/providers/page.dart';
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'external_api_page.dart';
import 'view_profile_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import '../constants.dart' as constants;
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = context.watch<CurrentPage>().isUserLoggedIn;
    int pageIndex = context.watch<CurrentPage>().pageIndex;
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(constants.primaryColor)),
      ),
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 280,
          leading:  Padding(
            padding: const EdgeInsets.only(left: 116, right: 2,),
            child: isUserLoggedIn ? Image.asset(
              constants.asgardeoLogo,
              scale:0.1,
            ): const Text(''),
          ),
        ),
        body: isUserLoggedIn
            ? pageIndex == constants.homePage
            ? const HomePage()
            : pageIndex == constants.profilePage
            ? const SingleChildScrollView(child: ProfilePage(),)
            : pageIndex == constants.externalAPIResponsePage
            ? const SingleChildScrollView(child: ExternalAPIDataPage())
            : pageIndex == constants.editProfilePage
            ? const SingleChildScrollView(child: EditProfilePage())
            : const LogInPage()
            : const LogInPage(),
      ),
    );
  }

}
