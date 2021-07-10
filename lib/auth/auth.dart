import 'package:flutter/foundation.dart';

class AuthData extends ChangeNotifier {

  static final AuthData _authdata = AuthData._internal();

  //private internal constructor to make it singleton
  AuthData._internal();

  static AuthData get() {
    return _authdata;
  }

  String token = "";
  bool isAuthenticated = false;
  String userId = "0";

  void logout() {
    isAuthenticated = false;
    token = "";
    userId = "0";
    notifyListeners();
  }

  void authenticate(String token, String userId) {
    isAuthenticated = true;
    token = token;
    userId = userId;
    notifyListeners();
    print(token);
  }
}


