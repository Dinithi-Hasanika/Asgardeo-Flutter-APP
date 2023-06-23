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
  late List<Album> _albums;

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
    _albums = [];
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
            ? HomePage(retrieveUserDetails, logOutFunction, callExternalAPIFunction)
            : _pageIndex == 3
            ? ProfilePage(_firstName, _lastName, _dateOfBirth, _country,
            _mobile, _photo, setPageIndex)
            : _pageIndex == 4
            ? ExternalAPIDataPage(_albums, setPageIndex)
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
          scopes: ['openid', 'profile', 'address', 'phone'],
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
      Uri.parse('http://localhost:9090/albums'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );
    if(externalInfo.statusCode == 200){
      List jsonList = jsonDecode(externalInfo.body);
      List<Album> albumList = [];
      for(var e in jsonList){
       Album album = new Album(title: e['title'], artist: e['artist']);
        albumList.add(album);
      }

      setState(() {
        _pageIndex = 4;
        _albums = albumList;
      });
    }else{
      print(externalInfo.statusCode);
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

  const HomePage(this.retriveProfileFunction, this.logOutFunction, this.callExternalAPIFunction);

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
  final List<Album> albums;

  const ExternalAPIDataPage(this.albums, this.setPageIndex);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('External API Data', style: TextStyle(fontSize: 30)),
          SizedBox(height: 40),
          ListView.builder(
            shrinkWrap: true,
              itemCount: albums.length,
              itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 20,
              child: Center(child: Text('Title:${albums[index].title}   Artist: ${albums[index].artist} ', style: TextStyle(fontSize: 15))),
            );
          }),
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

class Album{
  String title;
  String artist;

  Album({required this.title, required this.artist});
}