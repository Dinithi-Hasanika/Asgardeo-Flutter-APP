import 'package:flutter/foundation.dart';
import 'package:asgardeo_flutter_app/constants.dart' as constants;
import 'package:asgardeo_flutter_app/configs/configs.dart';

class User with ChangeNotifier, DiagnosticableTreeMixin{
  late String _firstName = '';
  late String _lastName = '';
  late String _dateOfBirth = '';
  late String _country = '';
  late String _mobile = '';
  late String _photo = '';

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get dateOfBirth => _dateOfBirth;

  String get country => _country;

  String get mobile => _mobile;

  String get photo => _photo;

  void setUserDetails(profile){
    _firstName = profile[constants.name][constants.givenName] ?? '';
    _lastName = profile[constants.name][constants.familyName] ?? '';
    _dateOfBirth = profile[constants.wso2Schema][constants.dob] ?? '';
    _country = profile[constants.wso2Schema][constants.country] ?? '';
    _mobile = profile[constants.phoneNumbers][0][constants.type] == constants.mobile? profile[constants.phoneNumbers][0][constants.value]:'';
    _photo = profile[constants.wso2Schema][constants.photo] ?? defaultPhotoURL;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('firstName', firstName));
    properties.add(StringProperty('lastName', lastName));
    properties.add(StringProperty('dateOfBirth', dateOfBirth));
    properties.add(StringProperty('country', country));
    properties.add(StringProperty('mobile', mobile));
    properties.add(StringProperty('photo', photo));
  }
}