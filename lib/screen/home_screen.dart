import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobi/config/default.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;        // main banner
  int _collectionIndex = 0;     // bộ sưu tập mới

  final List<String> sliderImages = [
    '${urlSlider}slider1.png',
    '${urlSlider}slider2.png',
    '${urlSlider}slider3.png',
  ];

  // 4 ảnh ví dụ cho “Bộ sưu tập mới nhất”
  final List<String> collectionImages = [
    '${urlBST}bst1.png',
    '${urlBST}bst2.png',
    '${urlBST}bst3.png',
    '${urlBST}bst4.png',
  ];

  late final List<List<String>> _pairs;
  final List<String> names = [
    'Luka 4 PF \'Navigator\'',
    'NIKE P-6000 PRM',
    'Nike C1TY \'Sand\'',
    'Nike Zoom Vomero 5',
    'Nike Air Max Dn',
    'Nike SB Dunk Low',
  ];
  late List<bool> _isLiked;

  @override
  void initState() {
    super.initState();
    // chia thành cặp 2 ảnh cho carousel bộ sưu tập
    _pairs = [];
    for (var i = 0; i < collectionImages.length; i += 2) {
      _pairs.add(
        (i + 1 < collectionImages.length)
            ? [collectionImages[i], collectionImages[i + 1]]
            : [collectionImages[i]],
      );
    }
    _isLiked = List<bool>.filled(names.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('JARDO', style: titleStyle.copyWith(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black)),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          Icon(Icons.favorite_border, color: Colors.black),
          Icon(Icons.notifications_none, color: Colors.black),
          Icon(Icons.shopping_bag_outlined, color: Colors.black),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // 1. Banner chính
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CarouselSlider(
              items: sliderImages.map((path) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(path, fit: BoxFit.cover, width: double.infinity),
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
                width: 8, height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == e.key ? Colors.black : Colors.grey[400],
                ),
              );
            }).toList(),
          ),

          // 2. Tiêu đề & nút “Xem tất cả”
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bộ sưu tập mới nhất', style: subTitleStyle),
                TextButton(
                  onPressed: () {},
                  child: const Text('Xem tất cả', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),

          // 3. Carousel 2 ảnh/slide
          CarouselSlider(
            items: _pairs.map((pair) {
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
                  width: 6, height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _collectionIndex == i ? Colors.black : Colors.grey[300],
                  ),
                );
              }),
            ),
          ),

          // 5. Phần “Khám phá sản phẩm” (grid 2 cột)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Khám phá sản phẩm', style: subTitleStyle),
                TextButton(
                  onPressed: () {},
                  child: const Text('Xem tất cả', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: names.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.75,
              ),
              itemBuilder: (ctx, i) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))],
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    // ảnh + nút Like
                    Expanded(
                      child: Stack(fit: StackFit.expand, children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.asset('${urlProduct}giay${i+1}.png', fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 8, right: 8,
                          child: IconButton(
                            icon: Icon(_isLiked[i] ? Icons.favorite : Icons.favorite_border,
                                       color: _isLiked[i] ? Colors.red : Colors.black),
                            onPressed: () => setState(() => _isLiked[i] = !_isLiked[i]),
                            splashRadius: 20,
                          ),
                        ),
                      ]),
                    ),
                    // tên
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                      child: Text(names[i],
                          style: productTitleStyle.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                    // giá
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Text('499,000đ', style: productPriceStyle),
                    ),
                  ]),
                );
              },
            ),
          ),

        ]),
      ),
    );
  }
}
