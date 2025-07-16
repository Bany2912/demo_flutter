import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductData {
  Future<List<ShoeProduct>> getProducts() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/files/product.json',
      );
      final data = json.decode(response); // Removed await here
      return (data['data'] as List).map((e) => ShoeProduct.fromJson(e)).toList();
    } catch (e) {
      print('Error loading products: $e');
      return [];
    }
  }
}