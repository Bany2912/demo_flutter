import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart'; // Import NumberFormat cho định dạng tiền tệ
import 'package:mobi/config/default.dart'; // Đảm bảo file này tồn tại và chứa các biến cần thiết
import 'package:mobi/models/product.dart'; // Đảm bảo import ShoeProduct model
import 'package:mobi/getdata/product_data.dart'; // Đảm bảo import ProductData để truy cập getProducts
import 'package:mobi/screen/productdetail_screen.dart'; // Màn hình chi tiết sản phẩm
import 'package:mobi/screen/cart_screen.dart'; // Import CartScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // main banner
  int _collectionIndex = 0; // bộ sưu tập mới

  // Khai báo _productsFuture là một Future chứa danh sách ShoeProduct
  late Future<List<ShoeProduct>> _productsFuture;

  // Khai báo NumberFormat để định dạng tiền tệ
  final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'vi_VN', // Định dạng cho Việt Nam
    symbol: '₫', // Ký hiệu Đồng
    decimalDigits: 0, // Không hiển thị số thập phân
  );

  final List<String> sliderImages = [
    '${urlSlider}slider1.png',
    '${urlSlider}slider2.png',
    '${urlSlider}slider3.png',
  ];

  final List<String> collectionImages = [
    '${urlBST}bst1.png',
    '${urlBST}bst2.png',
    '${urlBST}bst3.png',
    '${urlBST}bst4.png',
  ];

  late final List<List<String>> _pairs;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductData.getProducts(); // Tải dữ liệu sản phẩm
    _pairs = [];
    for (var i = 0; i < collectionImages.length; i += 2) {
      _pairs.add(
        (i + 1 < collectionImages.length)
            ? [collectionImages[i], collectionImages[i + 1]]
            : [collectionImages[i]],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clBackground, // Giả sử clBackground được định nghĩa trong default.dart
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'JARDON', // Đã sửa từ 'JARDO' thành 'JARDON' theo ảnh bạn cung cấp
          style: titleStyle.copyWith(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Xử lý tìm kiếm
            },
          ),
          const SizedBox(width: 8), // Khoảng cách
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              // Xử lý yêu thích
            },
          ),
          const SizedBox(width: 8), // Khoảng cách
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              // Xử lý thông báo
            },
          ),
          const SizedBox(width: 8), // Khoảng cách
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              // Điều hướng tới CartScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          const SizedBox(width: 8), // Khoảng cách cuối cùng cho padding bên phải
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Banner chính
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CarouselSlider(
                items: sliderImages.map((path) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(path, fit: BoxFit.cover, width: double.infinity),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 280,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  viewportFraction: 0.9,
                  onPageChanged: (i, _) => setState(() => _currentIndex = i),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: sliderImages.asMap().entries.map((e) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == e.key ? Colors.black : Colors.grey[400],
                  ),
                );
              }).toList(),
            ),

            // 2. Tiêu đề & nút “Xem tất cả” cho Bộ sưu tập
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bộ sưu tập mới nhất', style: subTitleStyle),
                  TextButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nhấn "Xem tất cả"
                    },
                    child: const Text('Xem tất cả', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),

            // 3. Carousel 2 ảnh/slide cho Bộ sưu tập
            CarouselSlider(
              items: _pairs.map((pair) {
                return Builder(
                  builder: (BuildContext context) {
                    return Row(
                      children: pair.map((imgPath) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(imgPath, height: 160, fit: BoxFit.cover),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 160,
                viewportFraction: 0.88,
                enableInfiniteScroll: _pairs.length > 1,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                onPageChanged: (i, _) => setState(() => _collectionIndex = i),
              ),
            ),

            // 4. Indicator cho bộ sưu tập
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pairs.length, (i) {
                  return Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _collectionIndex == i ? Colors.black : Colors.grey[300],
                    ),
                  );
                }),
              ),
            ),

            // 5. Tiêu đề & nút “Xem tất cả” cho Khám phá sản phẩm
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Khám phá sản phẩm', style: subTitleStyle),
                  TextButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nhấn "Xem tất cả"
                    },
                    child: const Text('Xem tất cả', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),

            // 6. Phần hiển thị sản phẩm sử dụng FutureBuilder (tải từ product.json)
            FutureBuilder<List<ShoeProduct>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print('Lỗi tải sản phẩm trong FutureBuilder: ${snapshot.error}'); // In lỗi ra console
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 50),
                          const SizedBox(height: 10),
                          Text(
                            'Không thể tải dữ liệu sản phẩm: ${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _productsFuture = ProductData.getProducts(); // Thử tải lại
                              });
                            },
                            child: const Text('Thử lại'),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Không có sản phẩm nào để hiển thị.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                } else {
                  final products = snapshot.data!; // Lấy tất cả sản phẩm
                  // Nếu bạn muốn giới hạn số lượng sản phẩm hiển thị, dùng .take(số_lượng)
                  // final products = snapshot.data!.take(6).toList();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true, // Cho phép GridView chỉ chiếm không gian cần thiết
                      physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn cho GridView
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (ctx, i) {
                        final product = products[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                        child: Image.asset(
                                          '${urlProduct}${product.mainImage}', // Sử dụng mainImage từ dữ liệu
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.favorite_border, // Mặc định là outline
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            // Xử lý logic thích/bỏ thích ở đây
                                          },
                                          splashRadius: 20,
                                        ),
                                      ),
                                      // Thêm nhãn "Mới" nếu cần dựa trên dữ liệu sản phẩm
                                      // Ví dụ: if (product.isNew)
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            'Mới',
                                            style: TextStyle(color: Colors.white, fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                                  child: Text(
                                    product.name,
                                    style: productTitleStyle.copyWith(fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                  child: Text(
                                    _currencyFormatter.format(product.price), // Định dạng giá từ dữ liệu
                                    style: productPriceStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}