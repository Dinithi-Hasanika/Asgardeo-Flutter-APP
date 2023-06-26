import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';

final FlutterAppAuth flutterAppAuth = FlutterAppAuth();

const clientId = 'TzpAhjAB5YHSHHfN0zP709FVgZoa';
const redirectUrl = 'wso2.asgardeo.flutterapp://login-callback';
const discoveryUrl =
    'https://api.asgardeo.io/t/dinithi/oauth2/token/.well-known/openid-configuration';
const userInfoEndpoint = 'https://api.asgardeo.io/t/dinithi/oauth2/userinfo';
const externalAPIEndpoint = 'http://localhost:9090/albums';
const meEndpoint = 'https://api.asgardeo.io/t/dinithi/scim2/Me';

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
            ? EditUserProfilePage(setPageIndex)
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
        _pageIndex = 2;
      });
    } catch (e, s) {
      print('Error while login to the system: $e - stack: $s');
      setState(() {
        _isUserLoggedIn = false;
      });
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
    }else{
      print(externalInfo.statusCode);
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
        _pageIndex = 5;

        //print('$_lastName $_country $_dateOfBirth $_mobile $_photo');
      });
    }
  }

  void logOutFunction() async {
    try {
      print('In logout');
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
}

class LogInPage extends StatelessWidget {
  final loginFunction;

  const LogInPage(this.loginFunction);

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [ElevatedButton(
          onPressed: () async {
            await loginFunction();
            // appState.userLogin();
          },
          child: Text('Sign In'),
        ),
          SizedBox(width: 50),
          ElevatedButton(
            onPressed: () async {
              await loginFunction();
              // appState.userLogin();
            },
            child: Text('Sign Up'),
          ),
        ]
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final retriveProfileFunction;
  final logOutFunction;
  final callExternalAPIFunction;
  final setPageIndex;
  final getUserProfileData;

  const HomePage(this.retriveProfileFunction, this.logOutFunction, this.callExternalAPIFunction, this.setPageIndex, this.getUserProfileData);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome!", style: TextStyle(fontSize: 35)),
          SizedBox(height: 100),
          ElevatedButton(
            onPressed: () async {
              await retriveProfileFunction();
            },
            child: Text('View profile'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
               await callExternalAPIFunction();
            },
            child: Text('Call External API'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await logOutFunction();
            },
            child: Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final firstName;
  final LastName;
  final dateOdBirth;
  final country;
  final mobile;
  final photo;
  final pageIndex;

  const ProfilePage(this.firstName, this.LastName, this.dateOdBirth, this.country,
      this.mobile, this.photo, this.pageIndex);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile Information", style: TextStyle(fontSize: 30)),
          SizedBox(height: 50),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 3.0),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(
                    photo ??
                        ''),
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Text('First Name: $firstName',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Last Name: $LastName',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Date of Birth: $dateOdBirth', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Mobile: $mobile', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Country: $country', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                  ],
                ),
              )),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              pageIndex(5);
            },
            child: Text('Edit Profile'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              pageIndex(2);
            },
            child: Text('Back to home'),
          ),
        ],
      ),
    );
  }
}

class ExternalAPIDataPage extends StatelessWidget{
  final setPageIndex;
  final String bodyResponse;

  const ExternalAPIDataPage(this.setPageIndex, this.bodyResponse);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('External API Data', style: TextStyle(fontSize: 30)),
          SizedBox(height: 40),
          Padding(padding: EdgeInsets.only(left:35, bottom: 0, right: 10, top:0), child: Text('$bodyResponse')),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              setPageIndex(2);
            },
            child: Text('Back to home'),
          ),
        ]
      ),
    );
  }

}

class EditUserProfilePage extends StatelessWidget{
  final setPageIndex;

   EditUserProfilePage(this.setPageIndex);




  @override
  Widget build(BuildContext context) {
    final TextEditingController _firstNameController = new TextEditingController();
    _firstNameController.text = 'abc';
    final TextEditingController _lastNameController = new TextEditingController();
    _lastNameController.text = 'pqr';
    final TextEditingController _countryController = new TextEditingController();
    _countryController.text = 'xyz';

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Edit User Profile', style: TextStyle(fontSize: 30)),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
            child: TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: "First Name", labelStyle: TextStyle(fontSize: 20)),
              onChanged: (text){
                print('value $text');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
            child: TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: "Last Name", labelStyle: TextStyle(fontSize: 20)),
              onChanged: (text){
                print('value $text');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:35, bottom: 10, right: 30, top:0),
            child: TextField(
              controller: _countryController,
              decoration: const InputDecoration(labelText: "Country", labelStyle: TextStyle(fontSize: 20)),
              onChanged: (text){
                print('value $text');
              },
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              setPageIndex(3);
            },
            child: Text('Save'),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              setPageIndex(2);
            },
            child: Text('Back to home'),
          ),
        ]
        )
    );
  }
  
}


