import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Đảm bảo đã import
import 'package:mobi/config/default.dart';
import 'package:mobi/models/product.dart'; // Đảm bảo đã import
import 'package:mobi/getdata/product_data.dart'; // Đảm bảo đã import

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Biến giả định cho giỏ hàng, trong thực tế bạn sẽ lấy từ trạng thái ứng dụng hoặc database
  final List<ShoeProduct> _cartItems = [
    ShoeProduct(
      id: "1",
      name: "Giày Luka 4 PF 'Navigator'",
      mainImage: "giay1.png",
      brandId: "nike",
      categoryId: 1,
      price: 499000.0, // Đảm bảo là double
      description: "Description for Luka 4 PF 'Navigator'",
      variants: [], // Có thể bỏ trống nếu không cần chi tiết variant trong giỏ hàng
    ),
    ShoeProduct(
      id: "2",
      name: "Air Jordan 1 Mid SE",
      mainImage: "giay2.png",
      brandId: "jordan",
      categoryId: 1,
      price: 499000.0, // Đảm bảo là double
      description: "Description for Air Jordan 1 Mid SE",
      variants: [],
    ),
  ];

  // Khởi tạo _productsFuture để tải dữ liệu sản phẩm
  late Future<List<ShoeProduct>> _productsFuture;

  @override
  void initState() {
    super.initState();
    // Gọi phương thức static
    _productsFuture = ProductData.getProducts();
    // _categories = CategoryData.getCategories(); // Nếu có CategoryData
  }

  final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    // Tổng tiền của các sản phẩm trong giỏ hàng
    // Sửa lỗi bằng cách khởi tạo sum là 0.0
    final totalAmount = _cartItems.fold(0.0, (sum, item) => sum + item.price);

    return Scaffold(
      backgroundColor: clBackground, // Sử dụng màu nền từ default.dart
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text('GIỎ HÀNG', style: titleStyle.copyWith(fontSize: 18, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Danh sách sản phẩm trong giỏ hàng
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final product = _cartItems[index];
                return _buildCartItem(product);
              },
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Phần "Sản phẩm yêu thích" (giả định)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Sản phẩm yêu thích', style: titleStyle.copyWith(fontSize: 18)),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<ShoeProduct>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Không thể tải dữ liệu sản phẩm: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  // Chỉ lấy 2 sản phẩm đầu tiên làm ví dụ cho "sản phẩm yêu thích"
                  final favoriteProducts = snapshot.data!.take(2).toList();
                  return SizedBox(
                    height: 250, // Chiều cao cố định cho ListView ngang
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: favoriteProducts.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        return _buildFavoriteProductCard(product);
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('Không có sản phẩm yêu thích nào.'));
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(totalAmount),
    );
  }

  Widget _buildCartItem(ShoeProduct product) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Checkbox
          Checkbox(value: true, onChanged: (bool? value) {}),
          // Ảnh sản phẩm
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              '${urlProduct}${product.mainImage}', // Sử dụng urlProduct từ default.dart
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Thông tin sản phẩm và số lượng
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: subTitleStyle.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _currencyFormatter.format(product.price),
                  style: productPriceStyle.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(Icons.remove, size: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text('1', style: subTitleStyle.copyWith(fontSize: 16)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(Icons.add, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildFavoriteProductCard(ShoeProduct product) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  '${urlProduct}${product.mainImage}',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border, size: 20, color: Colors.red),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: subTitleStyle.copyWith(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _currencyFormatter.format(product.price),
                  style: productPriceStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(double totalAmount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Checkbox(value: true, onChanged: (bool? value) {}),
              const Text('Tất cả', style: TextStyle(fontSize: 16)),
              const Spacer(),
              Text(
                'Tổng tiền:',
                style: subTitleStyle.copyWith(fontSize: 18),
              ),
              const SizedBox(width: 8),
              Text(
                _currencyFormatter.format(totalAmount),
                style: productPriceStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Xử lý khi nhấn "Tiếp tục"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Tiếp tục',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}