import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/brand.dart';

class BrandData {
  Future<List<Brand>> getBrands() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/files/brands.json', // Path to your brands JSON file
      );
      final List<dynamic> data = json.decode(response);
      return data.map((e) => Brand.fromJson(e)).toList();
    } catch (e) {
      print('Error loading brands: $e');
      return [];
    }
  }
}