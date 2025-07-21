import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobi/config/default.dart';
import 'productdetail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<String> sliderImages = [
    '${urlSlider}slider1.png',
    '${urlSlider}slider2.png',
    '${urlSlider}slider3.png',
  ];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. APP BAR
      backgroundColor: clBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Bỏ bóng đổ dưới AppBar
        title: const Text(
          'JARDO',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        backgroundColor: clBackground,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        title: Text(
          'JARDO',
          style: titleStyle.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  imgLogo,
                  width: 300,
                  fit: BoxFit.contain,
                ),
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.white.withOpacity(0.6),
                ),
              ],
            ),
          ),

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      CarouselSlider(
                        items: sliderImages.map((path) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              path,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 280,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 4),
                          viewportFraction: 0.9,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: sliderImages.asMap().entries.map((entry) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == entry.key
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bộ sưu tập mới nhất', style: subTitleStyle),
                      TextButton(
                        onPressed: () {},
                        child: Text('Xem tất cả', style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: 5,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            '${urlBST}bst${index + 1}.png',
                            width: 140,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Khám phá sản phẩm', style: subTitleStyle),
                      TextButton(
                        onPressed: () {},
                        child: Text('Xem tất cả', style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
                  GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                    List<String> names = [
                      'Nike Pegasus 41\n"Jakob Ingebrigtsen"',
                      'Luka 4 PF \'Navigator\'',
                      'NIKE P-6000 PRM',
                      'Nike Air Max 1',
                      'Nike Air Max Pulse',
                      'Nike Zoom Vomero 5',
                    ];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              productName: 'Giày Luka 4 PF \'Navigator\'',
                              productPrice: '499,000đ',
                              imageUrl: '${urlProduct}giay1.png', 
                            ),
                          ),
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
                            Container(
      ),
      // 2. BODY CÓ THỂ CUỘN
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bộ sưu tập mới nhất',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      
                    },
                    child: Text('Xem tất cả', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, 
                itemBuilder: (context, index) {
                  
                 Image.asset('assets/images/giay1.jpg');
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                            'assets/images/giay1.jpg',
                        width: 150, 
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

          
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Khám phá thêm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(), 
              shrinkWrap: true, 
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75, 
              ),
              itemCount: 6, 
              itemBuilder: (context, index) {
                
                Image.asset('assets/images/giay1.jpg'); // Thay đổi đường dẫn hình ảnh nếu cần
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/giay1.jpg',
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Image.asset(
                                      '${urlProduct}giay${index + 1}.png',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
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
                                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'Mới',
                                        style: TextStyle(color: Colors.white, fontSize: 10),
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
                                    names[index],
                                    style: productTitleStyle.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '499,000đ',
                                    style:productPriceStyle ,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
