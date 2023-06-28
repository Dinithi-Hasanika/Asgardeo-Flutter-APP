import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/editProfilePage.dart';
import 'pages/externalAPIPage.dart';
import 'pages/viewProfilePage.dart';
import 'pages/homePage.dart';
import 'pages/loginPage.dart';

final FlutterAppAuth flutterAppAuth = FlutterAppAuth();

const clientId = 'TzpAhjAB5YHSHHfN0zP709FVgZoa';
const redirectUrl = 'wso2.asgardeo.flutterapp://login-callback';
const discoveryUrl =
    'https://api.asgardeo.io/t/dinithi/oauth2/token/.well-known/openid-configuration';
const userInfoEndpoint = 'https://api.asgardeo.io/t/dinithi/oauth2/userinfo';
const externalAPIEndpoint = 'http://localhost:9090/albums';
const meEndpoint = 'https://api.asgardeo.io/t/dinithi/scim2/Me';
const signUpUrl = 'https://accounts.asgardeo.io/t/dinithi/accountrecoveryendpoint/register.do?client_id=TzpAhjAB5YHSHHfN0zP709FVgZoa&sp=asgardeo-flutterapp';

void main() {
  runApp(MyApp());
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

  @override
  void initState() {
    super.initState();
    _pageIndex = 1;
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asgardeo Flutter Integration',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Asgardeo Flutter Integration'),
        ),
        body: _isUserLoggedIn
            ? _pageIndex == 2
            ? HomePage(retrieveUserDetails, logOutFunction, callExternalAPIFunction, setPageIndex, getUserProfileData)
            : _pageIndex == 3
            ? ProfilePage(_firstName, _lastName, _dateOfBirth, _country,
            _mobile, _photo, setPageIndex)
            : _pageIndex == 4
            ? ExternalAPIDataPage(setPageIndex, _apiData)
            : _pageIndex == 5
            ? EditProfilePage(setPageIndex, _firstName, _lastName, _country, updateUserProfile)
            : LogInPage(loginFunction,signUpFunction)
            : LogInPage(loginFunction,signUpFunction),
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
      final AuthorizationTokenResponse? result =
      await flutterAppAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          promptValues: ['login'],
          scopes: ['openid', 'profile', 'address', 'phone', 'internal_login'],
        ),
      );

      setState(() {
        _isUserLoggedIn = true;
        _idToken = result?.idToken;
        _accessToken = result?.accessToken;
        _refreshToken = result?.refreshToken;
        _pageIndex = 2;
      });
    } catch (e, s) {
      print('Error while login to the system: $e - stack: $s');
      setState(() {
        _isUserLoggedIn = false;
      });
    }
  }

  Future<void> signUpFunction() async{
    if (!await launchUrl(Uri.parse(signUpUrl))) {
      throw Exception('Could not launch $signUpUrl');
    }
  }

  Future<void> retrieveUserDetails() async {

    final userInfoResponse = await http.get(
      Uri.parse( userInfoEndpoint),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );
    print(userInfoResponse.statusCode);

    if (userInfoResponse.statusCode == 200) {
      var profile = jsonDecode(userInfoResponse.body);
      setState(() {
        _firstName = profile['given_name'];
        _lastName = profile['family_name'];
        _dateOfBirth = profile['birthdate'];
        _country = profile['address']['country'];
        _mobile = profile['phone_number'];
        _photo = profile['picture'];
        _pageIndex = 3;
      });
    } else {
      throw Exception('Failed to get user profile information');
    }
  }

  Future<void> callExternalAPIFunction() async {
    final externalInfo = await http.get(
      Uri.parse(externalAPIEndpoint),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );
    if(externalInfo.statusCode == 200){
      List jsonList = jsonDecode(externalInfo.body);
      print(externalInfo.body);

      setState(() {
        _pageIndex = 4;
        _apiData =externalInfo.body;
      });
    }else if(externalInfo.statusCode == 401){
      print('----renewing access token ----');
      await renewAccessToken();
      await callExternalAPIFunction();
    }
  }

  Future<void> getUserProfileData() async {
    final userInfo = await http.get(
      Uri.parse(meEndpoint),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if(userInfo.statusCode == 200){
      print(userInfo.body);
      var profile = jsonDecode(userInfo.body);
      print(profile['name']['givenName']);
      setState(() {
        _firstName = profile['name']['givenName'];
        _lastName = profile['name']['familyName'];
        _dateOfBirth = profile['urn:scim:wso2:schema']['dateOfBirth'];
        _country = profile['urn:scim:wso2:schema']['country'];
        _mobile = profile['phoneNumbers'][0]['type'] == 'mobile'? profile['phoneNumbers'][0]['value']:'';
        _photo = profile['urn:scim:wso2:schema']['photoUrl'];
        _pageIndex = 3;
      });
    }else if(userInfo.statusCode == 401){
      print('----renewing access token ----');
      await renewAccessToken();
      await getUserProfileData();
    }
  }
  
  Future<void> updateUserProfile(firstName, lastName, country) async {
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
    final updatedInfo = await http.patch(
      Uri.parse(meEndpoint),
      headers: {'Authorization': 'Bearer $_accessToken', 'Content-Type': 'application/scim+json'},
      body: json.encode(data)
    );

    if(updatedInfo.statusCode == 200){
      var profile = jsonDecode(updatedInfo.body);
      setState(() {
        _firstName = profile['name']['givenName'];
        _lastName = profile['name']['familyName'];
        _dateOfBirth = profile['urn:scim:wso2:schema']['dateOfBirth'];
        _country = profile['urn:scim:wso2:schema']['country'];
        _mobile = profile['phoneNumbers'][0]['type'] == 'mobile'? profile['phoneNumbers'][0]['value']:'';
        _photo = profile['urn:scim:wso2:schema']['photoUrl'];
        _pageIndex = 3;
      });
    }else if(updatedInfo.statusCode == 401){
      print('----renewing access token ----');
      await renewAccessToken();
      await updateUserProfile(firstName, lastName, country);
    }

  }

  void logOutFunction() async {
    try {
      final EndSessionResponse? result = await flutterAppAuth.endSession(
        EndSessionRequest(
          idTokenHint: _idToken,
          postLogoutRedirectUrl: redirectUrl,
          discoveryUrl: discoveryUrl,
        ),
      );

      setState(() {
        _isUserLoggedIn = false;
        _pageIndex = 1;
      });
    } catch (e, s) {
      print('Error while logout from the system: $e - stack: $s');
    }
  }

  Future<void> renewAccessToken() async{
    print('before refreshing ${this._accessToken} ');
    try {
      final TokenResponse? tokenResponse = await flutterAppAuth.token(
          TokenRequest(clientId,
              redirectUrl,
              grantType: GrantType.refreshToken,
              refreshToken: this._refreshToken,
              discoveryUrl: discoveryUrl
          )
      );
      print(tokenResponse?.refreshToken);
      print('after refreshing ${tokenResponse?.accessToken} ');
      setState(() {
        _accessToken = tokenResponse?.accessToken;
        _refreshToken = tokenResponse?.refreshToken;
        _idToken = tokenResponse?.idToken;
      });
    } catch (e, s) {
      print('Error while refreshing the token: $e - stack: $s');
    }
  }
}
