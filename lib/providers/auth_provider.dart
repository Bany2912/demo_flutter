import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobi/models/user.dart';
import 'package:mobi/getdata/user_data.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = true;

  User? get user => _user;
  bool get isLoading => _isLoading;

  AuthProvider() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userPhone = prefs.getString('user_phone');
      
      if (userPhone != null) {
        final users = await UserData.getUsers();
        _user = users.firstWhere(
          (user) => user.phoneNumber == userPhone
        );
      }
    } catch (e) {
      print('Error checking login status: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_phone', user.phoneNumber);
      _user = user;
      notifyListeners();
    } catch (e) {
      print('Error logging in: $e');
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_phone');
      _user = null;
      notifyListeners();
    } catch (e) {
      print('Error logging out: $e');
      throw e;
    }
  }
}