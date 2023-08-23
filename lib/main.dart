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
            ? HomePage(logOutFunction, callExternalAPIFunction, setPageIndex, getUserProfileData, _userName)
            : pageIndex == constants.profilePage
            ? SingleChildScrollView(
              child: ProfilePage(_firstName, _lastName, _dateOfBirth, _country,
              _mobile, _photo, setPageIndex),
            )
            : pageIndex == constants.externalAPIResponsePage
            ? SingleChildScrollView(child: ExternalAPIDataPage(setPageIndex, _apiData))
            : pageIndex == constants.editProfilePage
            ? SingleChildScrollView(child: EditProfilePage(setPageIndex, _firstName, _lastName, _country, updateUserProfile))
            : LogInPage(loginFunction)
            : LogInPage(loginFunction),
      ),
    );
  }

  void setPageIndex(index) {
    setState(() {
      _pageIndex = index;
    });
  }

  Future<void> loginFunction() async {

    try {
      final AuthorizationTokenResponse? result = await AuthClient().authorize(flutterAppAuth);

      setState(() {
        _isUserLoggedIn = true;
        _idToken = result?.idToken;
        _accessToken = result?.accessToken;
        _refreshToken = result?.refreshToken;
      });

      if(context.mounted) {
        context.read<CurrentPage>().setPageAndUserStatus(constants.homePage, true);
        context.read<UserSession>().loginSuccessfulFunction(result?.accessToken, result?.idToken, result?.accessToken);
      }
      await getUserName();
    } catch (e, s) {
      print('Error while login to the system: $e - stack: $s');
      setState(() {
        _isUserLoggedIn = false;
      });
    }
  }

  Future<void> callExternalAPIFunction() async {

    final externalInfo = await HTTPClient().httpGet(externalAPIEndpoint, _accessToken);

    if (externalInfo.statusCode == constants.httpSuccessCode) {
      setState(() {
        _apiData =externalInfo.body.toString().replaceAll(",", ",\n");
      });
      if(context.mounted) {
        context.read<CurrentPage>().setPageIndex(constants.externalAPIResponsePage);
      }
    }else if (externalInfo.statusCode == constants.httpUnauthorizedCode) {
      try {
        await renewAccessToken();
        await callExternalAPIFunction();
      } catch(e,s) {
        print('Error while refreshing the token: $e - stack: $s');
        await loginFunction();
    }
    }
  }

  Future<void> getUserName() async {

    final userInfo = await HTTPClient().httpGet(meEndpoint, _accessToken);

    if (userInfo.statusCode == constants.httpSuccessCode) {
      var profile = jsonDecode(userInfo.body);
      setState(() {
        _userName = profile[constants.userName].toString().split(constants.domainSplit)[1];
      });
    }else if (userInfo.statusCode == constants.httpUnauthorizedCode) {
      try {
        await renewAccessToken();
        await getUserName();
      } catch(e,s) {
        print('Error while refreshing the token: $e - stack: $s');
        await loginFunction();
      }
    }
  }

  Future<void> getUserProfileData() async {

    final userInfo = await HTTPClient().httpGet(meEndpoint, _accessToken);

    if (userInfo.statusCode == constants.httpSuccessCode) {
      var profile = jsonDecode(userInfo.body);
      setState(() {
        _firstName = profile[constants.name][constants.givenName] ?? '';
        _lastName = profile[constants.name][constants.familyName] ?? '';
        _dateOfBirth = profile[constants.wso2Schema][constants.dob] ?? '';
        _country = profile[constants.wso2Schema][constants.country] ?? '';
        _mobile = profile[constants.phoneNumbers][0][constants.type] == constants.mobile? profile[constants.phoneNumbers][0][constants.value]:'';
        _photo = profile[constants.wso2Schema][constants.photo] ?? defaultPhotoURL;
       _userName = profile[constants.userName].toString().split(constants.domainSplit)[1];
      });
      if(context.mounted) {
        context.read<CurrentPage>().setPageIndex(constants.profilePage);
      }
    }else if (userInfo.statusCode == constants.httpUnauthorizedCode) {
      try {
        await renewAccessToken();
        await getUserProfileData();
      } catch (e, s) {
        print('Error while refreshing the token: $e - stack: $s');
        await loginFunction();
    }
    }
  }
  
  Future<void> updateUserProfile(firstName, lastName, country) async {

    Map data = Util().generateUpdateRequestBody(firstName, lastName, country);
    final updatedInfo = await HTTPClient().httpPatch(meEndpoint, _accessToken, data);

    if (updatedInfo.statusCode == constants.httpSuccessCode) {
      var profile = jsonDecode(updatedInfo.body);
      setState(() {
        _firstName = profile[constants.name][constants.givenName] ?? '';
        _lastName = profile[constants.name][constants.familyName] ?? '';
        _dateOfBirth = profile[constants.wso2Schema][constants.dob] ?? '';
        _country = profile[constants.wso2Schema][constants.country] ?? '';
        _mobile =  profile[constants.phoneNumbers][0][constants.type] == constants.mobile? profile[constants.phoneNumbers][0][constants.value]:'';
        _photo = profile[constants.wso2Schema][constants.photo] ?? defaultPhotoURL;
      });
      if(context.mounted) {
        context.read<CurrentPage>().setPageIndex(constants.profilePage);
      }
    }else if (updatedInfo.statusCode == constants.httpUnauthorizedCode) {
      try {
        await renewAccessToken();
        await updateUserProfile(firstName, lastName, country);
      } catch (e, s) {
        print('Error while refreshing the token: $e - stack: $s');
        await loginFunction();
      }
    }

  }

  void logOutFunction() async {

    try {
      await AuthClient().logOutUser(flutterAppAuth, _idToken);
      setState(() {
        _userName = '';
      });
      if(context.mounted) {
        context.read<CurrentPage>().setPageAndUserStatus(constants.firstPage,false);
      }
    } catch (e, s) {
      print('Error while logout from the system: $e - stack: $s');
    }
  }

  Future<void> renewAccessToken() async {

    final TokenResponse? tokenResponse = await AuthClient().refreshToken(flutterAppAuth, _refreshToken);
      setState(() {
        _accessToken = tokenResponse?.accessToken;
        _refreshToken = tokenResponse?.refreshToken;
        _idToken = tokenResponse?.idToken;
      });
  }
}
