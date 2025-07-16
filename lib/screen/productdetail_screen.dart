import 'package:flutter/material.dart';
import 'package:mobi/config/default.dart';


class ProductDetailPage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String imageUrl;

  const ProductDetailPage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
  });


  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  String _selectedSize = '41'; // Kích thước mặc định
  String _selectedVariantImage = 'images/variant_navigator.png'; // Ảnh biến thể mặc định

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clBackground,
      appBar: AppBar(
        backgroundColor: clBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            Center(
              child: Image.asset(
                _selectedVariantImage, // Sử dụng ảnh biến thể đã chọn
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: titleStyle.copyWith(color: Colors.black), // Giữ màu đen cho tiêu đề sản phẩm
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.productPrice,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Phiên bản: Navigator',
                    style: subTitleStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  // Lựa chọn biến thể
                  Row(
                    children: [
                      _buildVariantImage(
                          '${urlImg}variant_navigator.png', 'Navigator'),
                      const SizedBox(width: 10),
                      _buildVariantImage(
                          '${urlImg}variant_red.png', 'Red'), // Thay bằng ảnh biến thể khác
                      const SizedBox(width: 10),
                      _buildVariantImage(
                          '${urlImg}variant_green.png', 'Green'), // Thay bằng ảnh biến thể khác
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Size:',
                        style: subTitleStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Còn 38 sản phẩm',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Lựa chọn kích thước
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      _buildSizeOption('35'),
                      _buildSizeOption('36'),
                      _buildSizeOption('37'),
                      _buildSizeOption('38'),
                      _buildSizeOption('39'),
                      _buildSizeOption('40'),
                      _buildSizeOption('41'),
                      _buildSizeOption('42'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Số lượng:',
                    style: subTitleStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  // Bộ đếm số lượng
                  Row(
                    children: [
                      _buildQuantityButton(Icons.remove, () {
                        setState(() {
                          if (_quantity > 1) _quantity--;
                        });
                      }),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '$_quantity',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildQuantityButton(Icons.add, () {
                        setState(() {
                          _quantity++;
                        });
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  _buildFeatureRow(
                    'MIỄN PHÍ GIAO HÀNG TOÀN QUỐC',
                    '(Cho hóa đơn từ 300,000)',
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureRow(
                    'ĐỔI TRẢ DỄ DÀNG',
                    '(Đổi trả 30 ngày cho khách hàng nếu không vừa size hoặc lỗi do nhà sản xuất)',
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureRow(
                    'TỔNG ĐÀI BÁN HÀNG 1800 9999',
                    '(Miễn phí từ 8:00 - 21:00 mỗi ngày)',
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Thông tin chi tiết sản phẩm',
                    style: subTitleStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Được thiết kế dành cho những cầu thủ khó lường và quyết đoán như Luka Doncic, đôi giày này là vũ khí tối...',
                    style: productTitleStyle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 80), // Khoảng trống cuối cùng
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.favorite_border, size: 30),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 4,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý khi nhấn nút "Thêm vào giỏ hàng"
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Đã thêm ${widget.productName} size $_selectedSize, số lượng $_quantity vào giỏ hàng!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Thêm vào giỏ hàng'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantImage(String imagePath, String variantName) {
    bool isSelected = _selectedVariantImage == imagePath;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVariantImage = imagePath;
          // Có thể thêm logic để cập nhật các thuộc tính khác của sản phẩm dựa trên biến thể
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    bool isSelected = _selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = size;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: subTitleStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: productTitleStyle.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}

// Hàm main để chạy ứng dụng (ví dụ)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Detail Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductDetailPage(
        productName: "Giày Luka 4 PF 'Navigator'",
        productPrice: "499,000đ",
        imageUrl: '${urlProduct}giay1.png', 
      ),
    );
  }
}