// lib/screen/favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobi/models/product.dart';
import 'package:mobi/getdata/product_data.dart';
import 'package:mobi/providers/favorite_provider.dart';
import 'package:mobi/models/user.dart';
import 'package:mobi/getdata/user_data.dart';
import 'package:mobi/config/default.dart';

class FavoritesScreen extends StatefulWidget {
  final String userId;

  const FavoritesScreen({super.key, required this.userId});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<ShoeProduct> _allProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      _allProducts = await ProductData.getProducts();
    } catch (e) {
      print('Error loading products: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesProvider()..setUserId(widget.userId),
      child: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favoriteProducts = _allProducts
              .where((product) => favoritesProvider.productIds.contains(product.id))
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Danh sách yêu thích'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : favoriteProducts.isEmpty
                    ? const Center(child: Text('Không có sản phẩm yêu thích'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) {
                          final product = favoriteProducts[index];
                          return Card(
                            child: ListTile(
                              leading: Image.asset(
                               '$urlProduct${product.mainImage}',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(product.name),
                              subtitle: Text('${product.price.toStringAsFixed(0)} VND'),
                              trailing: IconButton(
                                icon: const Icon(Icons.favorite),
                                color: Colors.red,
                                onPressed: () => favoritesProvider.toggleFavorite(product.id),
                              ),
                            ),
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}