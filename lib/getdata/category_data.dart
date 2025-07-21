import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/category.dart';

class CategoryData {
  Future<List<Category>> getCategories() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/files/category.json',
      );
      
    
     
      final Map<String, dynamic> decodedData = json.decode(response);
      
      final List<dynamic> dataList = decodedData['data']; 
      
  
      return dataList.map((e) => Category.fromJson(e)).toList();
    } catch (e) {
      print('Error loading categories: $e'); // In lỗi ra console để debug
      return [];
    }
  }
}