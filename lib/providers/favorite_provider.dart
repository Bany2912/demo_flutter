// lib/providers/favorites_provider.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite.dart';

class FavoritesProvider extends ChangeNotifier {
  String _userId = '';
  List<String> _productIds = [];

  FavoritesProvider() {
    _loadInitialData();
  }

  String get userId => _userId;
  List<String> get productIds => _productIds;

  // Set user ID and load favorites
  Future<void> setUserId(String userId) async {
    if (_userId != userId && userId.isNotEmpty) {
      _userId = userId;
      await _loadFavorites();
      notifyListeners();
    }
  }

  // Load favorites from SharedPreferences
  Future<void> _loadFavorites() async {
    if (_userId.isEmpty) return; // Không tải nếu userId chưa được đặt
    final prefs = await SharedPreferences.getInstance();
    final favoriteJson = prefs.getString('favorites_$_userId');
    if (favoriteJson != null) {
      final favorite = Favorite.fromJson(jsonDecode(favoriteJson));
      _productIds = favorite.productIds;
    } else {
      _productIds = [];
    }
    notifyListeners();
  }

  // Initial data load (e.g., for testing)
  Future<void> _loadInitialData() async {
    // Không cần thiết nếu userId được set từ AuthProvider
  }

  // Save favorites to SharedPreferences
  Future<void> saveFavorites() async {
    if (_userId.isEmpty) return; // Không lưu nếu userId chưa được đặt
    final prefs = await SharedPreferences.getInstance();
    final favorite = Favorite(userId: _userId, productIds: _productIds);
    await prefs.setString('favorites_$_userId', jsonEncode(favorite.toJson()));
    notifyListeners();
  }

  // Toggle favorite status with login check
  Future<void> toggleFavorite(String productId) async {
    if (_userId.isEmpty) {
      throw Exception('User not logged in');
    }
    if (_productIds.contains(productId)) {
      _productIds.remove(productId);
    } else {
      _productIds.add(productId);
    }
    await saveFavorites();
  }

  // Clear all favorites for the user
  Future<void> clearFavorites() async {
    if (_userId.isEmpty) return;
    _productIds.clear();
    await saveFavorites();
  }
}