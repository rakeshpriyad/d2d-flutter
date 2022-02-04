import 'dart:async';
import 'dart:convert';

import 'package:d2d_flutter/utils/api-const.dart';
import 'package:d2d_flutter/utils/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  var MainUrl = ApiConst.authUrl;
  var AuthKey = ApiConst.authKey;
  static const _TIMEOUT = Duration(seconds: 100);
   String? _token;
   String? _userId;
   String? _userEmail;
   DateTime? _expiryDate;
   Timer? _authTimer;

   Auth(){
     _token ="";
     int timetoExpiry = 100;
     _authTimer = Timer(Duration(seconds: timetoExpiry!), logout);
   }

  bool get isAuth {
     String token = this.token!;
    if(!token.isEmpty){
      return true;
    }
    return false;
  }

  String? get token {
    /*if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
    */  return _token;
   // }
  }

  String? get userId {
    return _userId;
  }

  String? get userEmail {
    return _userEmail;
  }

  Future<void> logout() async {
    _token = null;
    _userEmail = null;
    _userId = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer?.cancel();
    }

    notifyListeners();

    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void _autologout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }

    final timetoExpiry = _expiryDate?.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timetoExpiry!), logout);
  }

  Future<bool> tryautoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(pref.getString('userData')! ) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedUserData!['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'] as String?;
    _userId = extractedUserData['userId'] as String?;
    _userEmail = extractedUserData['userEmail'] as String?;
    _expiryDate = expiryDate;
    notifyListeners();
    _autologout();

    return true;
  }

  Future<void> Authentication(
      String? email, String? password, String endpoint) async {
    try {
      //final url = '${MainUrl}';
      final response =  await http.post(
        Uri.parse(MainUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin" : "*",

        },
        body: jsonEncode(<String, String>{
          'userName': email!,
          'password': password!,
        }),
      ).timeout(_TIMEOUT);
/*
      final response = await http.post(Uri.parse(MainUrl),
          body: json.encode({
            'userName': email,
            'password': password
          }));*/

      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['token'];
      _userId = responseData['id'];
      _userEmail = responseData['userName'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: 200));

      _autologout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'userEmail': _userEmail,
        'expiryDate': _expiryDate?.toIso8601String(),
      });

      prefs.setString('userData', userData);

      print('check' + userData.toString());
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(String email, String password) {
    return Authentication(email, password, 'signInWithPassword');
  }

  Future<void> signUp(String? email, String? password) {
    return Authentication(email, password, 'signUp');
  }
}
