import 'package:asgardeo_flutter_app/providers/page.dart';
import 'package:asgardeo_flutter_app/providers/user.dart';
import 'package:asgardeo_flutter_app/providers/user_session.dart';
import 'package:asgardeo_flutter_app/utils/http_client.dart';
import 'package:asgardeo_flutter_app/utils/Auth.dart';
import 'package:asgardeo_flutter_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'pages/editProfilePage.dart';
import 'pages/externalAPIPage.dart';
import 'pages/viewProfilePage.dart';
import 'pages/homePage.dart';
import 'pages/loginPage.dart';
import 'configs/configs.dart';
import 'configs/endPointUrls.dart';
import 'constants.dart' as constants;
import 'package:provider/provider.dart';

final FlutterAppAuth flutterAppAuth = FlutterAppAuth();

void main() {
  // runApp(MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => UserSession()),
        ChangeNotifierProvider(create: (_) => CurrentPage()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late int _pageIndex;
  late bool _isUserLoggedIn;
  late String? _idToken;
  late String? _accessToken;
  late String? _refreshToken;
  late String? _firstName;
  late String? _lastName;
  late String? _dateOfBirth;
  late String? _country;
  late String? _mobile;
  late String? _photo;
  late String _apiData;
  late String? _userName;

  @override
  void initState() {
    super.initState();
    _pageIndex = constants.firstPage;
    _isUserLoggedIn = false;
    _idToken = '';
    _accessToken = '';
    _refreshToken = '';
    _firstName = '';
    _lastName = '';
    _dateOfBirth = '';
    _country = '';
    _mobile = '';
    _photo = '';
    _apiData ='';
    _userName = '';
  }

  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = context.watch<CurrentPage>().isUserLoggedIn;
    int pageIndex = context.watch<CurrentPage>().pageIndex;
    return MaterialApp(
      title: constants.appTitle,
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

          //title: Text(constants.appTitle),
        ),
        body: isUserLoggedIn
            ? pageIndex == constants.homePage
            ? HomePage( _userName)
            : pageIndex == constants.profilePage
            ? SingleChildScrollView(
              child: ProfilePage(_firstName, _lastName, _dateOfBirth, _country,
              _mobile, _photo),
            )
            : pageIndex == constants.externalAPIResponsePage
            ? SingleChildScrollView(child: ExternalAPIDataPage( _apiData))
            : pageIndex == constants.editProfilePage
            ? SingleChildScrollView(child: EditProfilePage( _firstName, _lastName, _country))
            : LogInPage()
            : LogInPage(),
      ),
    );
  }

}
