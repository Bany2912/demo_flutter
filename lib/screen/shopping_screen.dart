import 'package:flutter/material.dart';
import 'package:mobi/config/default.dart'; // Ensure this file and urlProduct are defined
import 'package:mobi/screen/productdetail_screen.dart';
import 'package:mobi/getdata/product_data.dart';
import 'package:mobi/getdata/category_data.dart'; // Ensure you have CategoryData
import 'package:mobi/models/product.dart';
import 'package:mobi/models/category.dart'; // Ensure you have Category model
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:mobi/providers/favorite_provider.dart'; // Import the FavoritesProvider
import 'package:mobi/providers/auth_provider.dart'; // Import AuthProvider
import 'login_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<ShoeProduct>> _products;
  late Future<List<Category>> _categories;
  int _selectedCategoryId = 0;

  @override
  void initState() {
    super.initState();
    _products = ProductData.getProducts();
    _categories = CategoryData().getCategories(); // Adjust if getCategories is static
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'vi',
      symbol: '₫',
      decimalDigits: 0,
    );

    return ChangeNotifierProvider(
      create: (_) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        return FavoritesProvider()..setUserId(authProvider.user?.id ?? 'user1');
      },
      child: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sản phẩm',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    'Bộ sưu tập',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FutureBuilder<List<Category>>(
                      future: _categories,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Text('No categories found.');
                        }

                        final categories = snapshot.data!;
                        List<Widget> filterButtons = [
                          _buildFilterButton(null),
                          const SizedBox(width: 8),
                        ];

                        for (var category in categories) {
                          filterButtons.add(_buildFilterButton(category));
                          filterButtons.add(const SizedBox(width: 8));
                        }

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: filterButtons),
                        );
                      },
                    ),
                  ),
                ),
              ),
              elevation: 0,
            ),
            body: Stack(
              children: [
                Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'images/logobackground.png',
                      width: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                FutureBuilder<List<ShoeProduct>>(
                  future: _products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Không có sản phẩm nào.'));
                    }

                    final allProducts = snapshot.data!;
                    List<ShoeProduct> displayedProducts = _selectedCategoryId == 0
                        ? allProducts
                        : allProducts
                            .where((p) => p.categoryId == _selectedCategoryId)
                            .toList();

                    if (displayedProducts.isEmpty) {
                      return const Center(
                        child: Text('Không có sản phẩm nào trong danh mục này.'),
                      );
                    }

                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = displayedProducts[index];
                        final isFavorite = favoritesProvider.productIds.contains(product.id);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                        child: Image.asset(
                                          '$urlProduct${product.mainImage}',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                          alignment: Alignment.center,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  color: Colors.grey,
                                                  size: 40,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: IconButton(
                                          icon: Icon(
                                            isFavorite ? Icons.favorite : Icons.favorite_border,
                                            color: isFavorite ? Colors.red : null,
                                          ),
                                          onPressed: () {
                                            final authProvider = Provider.of<AuthProvider>(context, listen: false);
                                            if (authProvider.user == null) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text('Vui lòng đăng nhập để yêu thích sản phẩm'),
                                              
                                                ),
                                              );
                                              return;
                                            }
                                            favoritesProvider.toggleFavorite(product.id);
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            'Mới',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: productTitleStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        currencyFormatter.format(product.price),
                                        style: productPriceStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterButton(Category? category) {
    String buttonText = category?.name ?? 'Tất cả';
    int buttonCategoryId = category?.id ?? 0;

    bool isSelected = _selectedCategoryId == buttonCategoryId;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryId = buttonCategoryId;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.black : Colors.grey),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}