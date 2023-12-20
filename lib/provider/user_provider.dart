import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  late Map _userData;
  late dynamic _userJwt;
  var _userName;

  dynamic get userData => _userData;
  dynamic get userJwt => _userJwt;
  dynamic get userName => _userName;

  void setUserData(Map data) {
    _userData = data;
    _userJwt = data['accessToken'];
    _userName = data['username'];
    print('UserProviderdata');
    print(_userData);
    print('UserProviderjwt');
    print(_userJwt);
    print('UserProviderName');
    print(_userName);
    notifyListeners();
  }

}

  // final String jwt;
  // final Map<String, dynamic> data;

  // context.read<UserProvider>().userJwt

// import 'package:provider/provider.dart';
// import '../provider/user_provider.dart';