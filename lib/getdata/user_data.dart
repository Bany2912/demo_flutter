import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mobi/models/user.dart';

class UserData {
  static Future<List<User>> getUsers() async {
    try {
      // Load the JSON file
      final String jsonString = await rootBundle.loadString('assets/files/user.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Convert JSON to List<User>
      final List<dynamic> usersJson = jsonData['data'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      print('Error loading users: $e');
      return [];
    }
  }

  static Future<User?> getUserById(String id) async {
    try {
      final users = await getUsers();
      return users.firstWhere((user) => user.id == id);
    } catch (e) {
      print('Error finding user: $e');
      return null;
    }
  }
}