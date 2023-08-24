import 'package:flutter/foundation.dart';

import '../configs/configs.dart';
import '../constants/app_constants.dart';

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
    _firstName = profile[AppConstants.name][AppConstants.givenName] ?? '';
    _lastName = profile[AppConstants.name][AppConstants.familyName] ?? '';
    _dateOfBirth = profile[AppConstants.wso2Schema][AppConstants.dob] ?? '';
    _country = profile[AppConstants.wso2Schema][AppConstants.country] ?? '';
    _mobile = profile[AppConstants.phoneNumbers][0][AppConstants.type] == AppConstants.mobile? profile[AppConstants.phoneNumbers][0][AppConstants.value]:'';
    _photo = profile[AppConstants.wso2Schema][AppConstants.photo] ?? defaultPhotoURL;
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