import 'package:flutter/foundation.dart';
import 'package:mobi/models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  bool _isLoading = false;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  
  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  int get itemCount => _items.length;

  Future<void> addToCart(
    ShoeProduct product, 
    ShoeVariant variant, 
    String size, 
    {int quantity = 1}
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate network delay in real app you might call an API here
      await Future.delayed(const Duration(milliseconds: 500));

      final existingIndex = _items.indexWhere(
        (item) => item.product.id == product.id && 
                  item.variant.id == variant.id && 
                  item.size == size
      );

      if (existingIndex >= 0) {
        _items[existingIndex].quantity += quantity;
      } else {
        _items.add(CartItem(
          product: product,
          variant: variant,
          size: size,
          quantity: quantity,
        ));
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int newQuantity) {
    if (newQuantity > 0) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    } else {
      removeFromCart(index);
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  CartItem? findCartItem(String productId, String variantId, String size) {
    try {
      return _items.firstWhere(
        (item) => 
          item.product.id == productId && 
          item.variant.id == variantId && 
          item.size == size
      );
    } catch (e) {
      return null;
    }
  }
}

class CartItem {
  final ShoeProduct product;
  final ShoeVariant variant;
  final String size;
  int quantity;

  CartItem({
    required this.product,
    required this.variant,
    required this.size,
    this.quantity = 1,
  });

  double get total => product.price * quantity;
}