import 'package:flutter/material.dart';
import 'package:mobi/config/default.dart';
import 'package:mobi/screen/productdetail_screen.dart';
import 'package:mobi/getdata/product_data.dart';
import 'package:mobi/getdata/category_data.dart';
import 'package:mobi/models/product.dart';
import 'package:mobi/models/category.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<ShoeProduct>> _products;
  late Future<List<Category>> _categories;
  // Biến trạng thái để theo dõi danh mục được chọn
  // _selectedCategoryId = 0 đại diện cho "Tất cả"
  int _selectedCategoryId = 0;

  @override
  void initState() {
    super.initState();
    _products = ProductData().getProducts();
    _categories = CategoryData().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
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
          preferredSize: Size.fromHeight(40.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<List<Category>>(
                future: _categories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No categories found.');
                  }

                  final categories = snapshot.data!;

                  // Tạo danh sách các widget nút lọc
                  List<Widget> filterButtons = [
                    // Nút "Tất cả"
                    _buildFilterButton(null), // Truyền null để đại diện cho "Tất cả"
                    SizedBox(width: 8),
                  ];

                  // Thêm các nút từ dữ liệu categories đã lấy được
                  for (var category in categories) {
                    filterButtons.add(_buildFilterButton(category));
                    filterButtons.add(SizedBox(width: 8));
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filterButtons,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<List<ShoeProduct>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found.'));
          }

          final allProducts = snapshot.data!;
          List<ShoeProduct> displayedProducts;

          // Logic lọc sản phẩm
          if (_selectedCategoryId == 0) {
            // Nếu "Tất cả" được chọn, hiển thị tất cả sản phẩm
            displayedProducts = allProducts;
          } else {
            // Lọc sản phẩm theo categoryId
            displayedProducts = allProducts
                .where((product) => product.categoryId == _selectedCategoryId)
                .toList();
          }

          if (displayedProducts.isEmpty) {
            return Center(child: Text('Không có sản phẩm nào trong danh mục này.'));
          }

          return GridView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: displayedProducts.length,
            itemBuilder: (context, index) {
              final product = displayedProducts[index]; // Sử dụng danh sách đã lọc

              return GestureDetector(
                onTap: () {
                  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailScreen(product: product)),
    );
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
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
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.asset(
                                '$urlProduct${product.mainImage}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.center,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(Icons.favorite_border),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
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
                              NumberFormat.currency(
                                locale: 'vi',
                                symbol: '₫',
                              ).format(product.price),
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
    );
  }

  // Cập nhật hàm _buildFilterButton để nhận một đối tượng Category
  // (null nếu là nút "Tất cả")
  Widget _buildFilterButton(Category? category) {
    // Nếu category là null, đây là nút "Tất cả"
    String buttonText = category?.name ?? 'Tất cả';
    int buttonCategoryId = category?.id ?? 0; // 0 cho "Tất cả"

    // Kiểm tra xem nút này có đang được chọn hay không
    bool isSelected = _selectedCategoryId == buttonCategoryId;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryId = buttonCategoryId;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[200] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.grey),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}