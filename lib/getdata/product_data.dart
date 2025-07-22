// lib/getdata/product_data.dart (hoặc nơi file của bạn đang nằm)
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart'; // Đảm bảo đường dẫn này đúng tới file product.dart

class ProductData {
  // THÊM TỪ KHÓA 'static' VÀO ĐÂY
  static Future<List<ShoeProduct>> getProducts() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/files/product.json', // Đã điều chỉnh đường dẫn file JSON
      );
      final data = json.decode(response);
      
      // Đảm bảo xử lý đúng cấu trúc JSON có key 'data'
      if (data is Map && data.containsKey('data') && data['data'] is List) {
        return (data['data'] as List).map((e) => ShoeProduct.fromJson(e)).toList();
      } else {
        throw Exception('Cấu trúc JSON không hợp lệ: thiếu hoặc sai key "data".');
      }
    } catch (e) {
      print('Lỗi khi tải sản phẩm: $e');
      return [];
    }
  }
}