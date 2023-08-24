import 'package:flutter/foundation.dart';

class UserSession with ChangeNotifier, DiagnosticableTreeMixin{
  late String _accessToken = '';
  late String _idToken = '';
  late String _refreshToken = '';
  late String _userName = '';

  String get accessToken => _accessToken;

  String get idToken => _idToken;

  String get refreshToken => _refreshToken;

  String get userName => _userName;

  void loginSuccessfulFunction(accessToken, idToken, refreshToken){
    _accessToken = accessToken;
    _idToken = idToken;
    _refreshToken = refreshToken;
    notifyListeners();
  }

  void setUserName(userName){
    _userName = userName;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('accessToken', accessToken));
    properties.add(StringProperty('idToken', idToken));
    properties.add(StringProperty('refreshToken', refreshToken));
    properties.add(StringProperty('userName', userName));
  }
}