import 'package:flutter/foundation.dart';

import '../constants/app_constants.dart';

class CurrentPage with ChangeNotifier, DiagnosticableTreeMixin{
  late int _pageIndex = AppConstants.firstPage;
  late bool _isUserLoggedIn = false;
  late String _apiData = 'Can not Retrieve API Data';

  int get pageIndex => _pageIndex;

  bool get isUserLoggedIn => _isUserLoggedIn;

  String get apiData => _apiData;

  void setPageIndex(pageIndex){
    _pageIndex = pageIndex;
    notifyListeners();
  }

  void setPageAndUserStatus(pageIndex, isUserLoggedIn){
    _isUserLoggedIn = isUserLoggedIn;
    _pageIndex = pageIndex;
    notifyListeners();
  }

  void setExternalAPIPage(pageIndex, apiData){
    _pageIndex = pageIndex;
    _apiData = apiData;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('pageIndex', pageIndex));
    properties.add(FlagProperty('isUserLoggedIn', value: isUserLoggedIn));
    properties.add(StringProperty('apiData', apiData));
  }
}