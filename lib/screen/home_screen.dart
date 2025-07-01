import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


// Đây là nơi chứa toàn bộ nội dung của trang chủ
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSliderIndex = 0;
  final List<String> imgList = [
    'assets/images/2.jpg', // Thay bằng đường dẫn ảnh của bạn
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
    
  ];
    final List<String> _bannerImages = [
    'assets/images/giay1.jpg',
    'assets/images/luka 4.jpg',
    ];
      int _currentBannerIndex = 0; // Thêm biến để theo dõi banner đang hiển thị


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Bỏ bóng đổ dưới AppBar
        title: const Text(
          'JARDO',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
          ),
        ],
      ),
      // 2. BODY CÓ THỂ CUỘN
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2.1. IMAGE SLIDER
            _buildImageSlider(),

            // 2.2. DẤU CHẤM CHỈ BÁO SLIDER
            _buildSliderIndicator(),

            const SizedBox(height: 24),

            // 2.3. TIÊU ĐỀ MỤC
            _buildSectionHeader('Bộ sưu tập mới nhất', () {
              // Xử lý khi nhấn "Xem tất cả"
            }),

            const SizedBox(height: 16),

            // 2.4. HAI BANNER LỚN
            _buildCollectionBanners(),

            const SizedBox(height: 24),
        
            // 2.5. LƯỚI SẢN PHẨM
            _buildProductGrid( ),

            
          ],
        ),
      ),
    );
  }

  // Widget cho Image Slider
  Widget _buildImageSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0, // Hiển thị 1 ảnh đầy đủ
        onPageChanged: (index, reason) {
          setState(() {
            _currentSliderIndex = index;
          });
        },
      ),
      items: imgList
          .map((item) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                ),
              ))
          .toList(),
    );
  }

  // Widget cho các dấu chấm chỉ báo
  Widget _buildSliderIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                  .withOpacity(_currentSliderIndex == entry.key ? 0.9 : 0.4)),
        );
      }).toList(),
    );
  }

  // Widget cho tiêu đề mục (ví dụ: "Bộ sưu tập mới nhất")
  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: const Text(
              'Xem tất cả',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  // Widget cho 2 banner quảng cáo
    // Widget cho banner quảng cáo - PHIÊN BẢN CAROUSEL
  Widget _buildCollectionBanners() {
    return CarouselSlider.builder(
      itemCount: _bannerImages.length,
      itemBuilder: (context, index, realIndex) {
        final imagePath = _bannerImages[index];
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover, // Vẫn dùng BoxFit.cover để ảnh đẹp
            ),
          ),
        );
      },
      options: CarouselOptions(
        // Tỷ lệ khung hình cho banner, ví dụ 16:9 hoặc 2:1
        aspectRatio: 2.0, 
        // Phóng to item ở giữa một chút
        enlargeCenterPage: true, 
        // Tự động chạy
        autoPlay: true, 
        // Thời gian chờ giữa các lần chuyển ảnh
        autoPlayInterval: const Duration(seconds: 4), 
        // Khi người dùng vuốt, cập nhật lại index của banner hiện tại
        onPageChanged: (index, reason) {
          setState(() {
            _currentBannerIndex = index;
          });
        },
      ),
    );
  }
              

  
  Widget _buildProductGrid() {
    
    final List<Map<String, String>> products = [
      {'image': 'assets/images/giay1.jpg', 'name': 'Nike Pegasus 41', 'price': '499,000đ', 'tag': 'Mới'},
      {'image': 'assets/images/luka 4.jpg', 'name': 'Luka 4 PF \'Navigator\'', 'price': '499,000đ'},
      {'image': 'assets/images/product3.png', 'name': 'NIKE P-6000 PRM', 'price': '499,000đ'},
      {'image': 'assets/images/product4.png', 'name': 'Nike Dunk Low', 'price': '499,000đ', 'tag': 'Sale'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        // Quan trọng: những thuộc tính này cần khi GridView nằm trong SingleChildScrollView
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cột
          crossAxisSpacing: 10, // Khoảng cách ngang
          mainAxisSpacing: 10, // Khoảng cách dọc
          childAspectRatio: 0.7, // Tỷ lệ chiều rộng/chiều cao của mỗi item
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductItem(products[index]);
        },
      ),
    );
  }
  
  // Widget cho một item sản phẩm
  Widget _buildProductItem(Map<String, String> product) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 1. Dùng AspectRatio để đảm bảo tất cả các khung ảnh có tỷ lệ 1:1 (hình vuông)
      // Hoặc bạn có thể dùng Expanded như code gốc cũng được.
      AspectRatio(
        aspectRatio: 1.0, // Tỷ lệ chiều rộng / chiều cao. 1.0 là hình vuông.
        child: Stack(
          children: [
            // 2. Dùng Container để tạo cái "khung" cho ảnh
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Màu nền trong lúc ảnh tải hoặc cho khoảng trống
                borderRadius: BorderRadius.circular(8),
                // 3. Đặt ảnh làm nền cho Container
                image: DecorationImage(
                  // Lấy ảnh từ assets
                  image: AssetImage(product['image']!),
                  // 4. ĐÂY LÀ PHẦN QUAN TRỌNG NHẤT
                  // Ra lệnh cho ảnh lấp đầy Container và cắt phần thừa
                  fit: BoxFit.cover, 
                ),
              ),
            ),
            // Các widget khác trong Stack như trái tim, tag sale...
            Positioned(
              top: 8,
              right: 8,
              child: Icon(Icons.favorite_border, color: Colors.grey.shade600),
            ),
            if (product['tag'] != null)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    product['tag']!,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product['name']!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          product['price']!,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }
}