import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
<<<<<<< HEAD

const String urlSlider   = 'images/slider/';
const String urlBST      = 'images/BST/';
const String urlProducts = 'images/product/';

const Color kBackgroundGray = Color(0xFFF2F2F2);
const Color kPrimaryBlack   = Colors.black;
const Color kAccentRed      = Colors.red;
const Color kTextGray       = Colors.grey;

final TextStyle kTitleStyle = TextStyle(
  fontSize: 26, fontWeight: FontWeight.w900, color: kPrimaryBlack,
);
final TextStyle kSubtitleStyle = TextStyle(
  fontSize: 18, fontWeight: FontWeight.w600, color: kPrimaryBlack,
);
final TextStyle kCardTitleStyle = TextStyle(
  fontSize: 14, fontWeight: FontWeight.bold, color: kPrimaryBlack,
);
final TextStyle kCardPriceStyle = TextStyle(
  fontSize: 14, fontWeight: FontWeight.w600, color: kPrimaryBlack,
);

// Data models
class CollectionItem {
  final String imagePath;
  final String title;
  const CollectionItem({required this.imagePath, required this.title});
}

class ProductItem {
  final String name;
  final String imagePath;
  final int price;
  bool isLiked;
  ProductItem({
    required this.name,
    required this.imagePath,
    required this.price,
    this.isLiked = false,
  });
}
=======
import 'package:mobi/config/default.dart';
import 'productdetail_screen.dart';
import 'package:mobi/getdata/product_data.dart';
import 'package:mobi/models/product.dart';
import 'package:intl/intl.dart';
>>>>>>> f8e6752157cab7a697e4de6df0b79daad879b980

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;

  final sliderImages = [
    '${urlSlider}slider1.png',
    '${urlSlider}slider2.png',
    '${urlSlider}slider3.png',
  ];

<<<<<<< HEAD
  final collections = const [
    CollectionItem(imagePath: '${urlBST}bst1.png', title: 'Giày chạy bộ'),
    CollectionItem(imagePath: '${urlBST}bst2.png', title: 'Giày bóng rổ'),
    CollectionItem(imagePath: '${urlBST}bst3.png', title: 'Giày thời trang'),
    CollectionItem(imagePath: '${urlBST}bst4.png', title: 'Giày Jordan'),
  ];

  late final List<ProductItem> products;

  // Filter state
  RangeValues _priceRange = const RangeValues(0, 2000000);
  final List<String> _sizeOptions  = ['36','37','38','39','40','41','42'];
  final List<String> _brandOptions = ['Giày chạy bộ','Chạy thời tra ','Giày bóng rổ'];
  final List<Color>  _colorOptions = [
    Colors.black, Colors.white, Colors.red, Colors.blue
  ];
  final Set<String> _selectedSizes  = {};
  final Set<String> _selectedBrands = {};
  final Set<Color>  _selectedColors = {};

  @override
  void initState() {
    super.initState();
    products = List.generate(6, (i) {
      return ProductItem(
        name: [
          'Luka 4 PF Navigator',
          'NIKE P-6000 PRM',
          'Nike C1TY Sand',
          'Zoom Vomero 5',
          'Air Max Dn',
          'SB Dunk Low Pro',
        ][i],
        imagePath: '${urlProducts}giay${i + 1}.png',
        price: 499000,
      );
    });
  }

  // Unified search + filter modal
  void _showSearchFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 1. Search field
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm giày bạn thích…',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
=======
  late Future<List<ShoeProduct>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductData().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clBackground,
      appBar: AppBar(
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
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
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
                Image.asset(imgLogo, width: 300, fit: BoxFit.contain),
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
                      ),
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
                        child: Text(
                          'Xem tất cả',
                          style: TextStyle(color: Colors.grey),
                        ),
>>>>>>> f8e6752157cab7a697e4de6df0b79daad879b980
                      ),
                    ),
                    onSubmitted: (q) {
                      // TODO: handle search query
                    },
                  ),
<<<<<<< HEAD

                  const SizedBox(height: 24),

                  // 2. Price filter
                  Text('Giá', style: kSubtitleStyle),
                  RangeSlider(
                    values: _priceRange,
                    min: 0, max: 2000000, divisions: 20,
                    labels: RangeLabels(
                      '${_priceRange.start.round()}đ',
                      '${_priceRange.end.round()}đ',
                    ),
                    onChanged: (v) => setModalState(() => _priceRange = v),
                  ),

                  const SizedBox(height: 16),

                  // 3. Size filter
                  Text('Size', style: kSubtitleStyle),
                  Wrap(
                    spacing: 8,
                    children: _sizeOptions.map((s) {
                      return FilterChip(
                        label: Text(s),
                        selected: _selectedSizes.contains(s),
                        onSelected: (sel) => setModalState(() {
                          sel ? _selectedSizes.add(s) : _selectedSizes.remove(s);
                        }),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // 4. Brand filter
                  Text('Loại giày ', style: kSubtitleStyle),
                  Wrap(
                    spacing: 8,
                    children: _brandOptions.map((b) {
                      return FilterChip(
                        label: Text(b),
                        selected: _selectedBrands.contains(b),
                        onSelected: (sel) => setModalState(() {
                          sel ? _selectedBrands.add(b) : _selectedBrands.remove(b);
                        }),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // 5. Color filter
                  Text('Màu', style: kSubtitleStyle),
                  Wrap(
                    spacing: 8,
                    children: _colorOptions.map((c) {
                      return ChoiceChip(
                        label: const SizedBox.shrink(),
                        selectedColor: c,
                        selected: _selectedColors.contains(c),
                        backgroundColor: c.withOpacity(0.6),
                        onSelected: (sel) => setModalState(() {
                          sel ? _selectedColors.add(c) : _selectedColors.remove(c);
                        }),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // 6. Clear & Apply
                  Row(
=======
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
>>>>>>> f8e6752157cab7a697e4de6df0b79daad879b980
                    children: [
                      TextButton(
<<<<<<< HEAD
                        onPressed: () => setModalState(() {
                          _priceRange = const RangeValues(0, 2000000);
                          _selectedSizes.clear();
                          _selectedBrands.clear();
                          _selectedColors.clear();
                        }),
                        child: const Text('Xóa hết'),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {}); // apply filter
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Áp dụng'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
=======
                        onPressed: () {},
                        child: Text(
                          'Xem tất cả',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<List<ShoeProduct>>(
                  future: _productsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No products found.'));
                    }

                    final products = snapshot.data!.take(6).toList();

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85, // Giữ nguyên hoặc điều chỉnh nếu muốn ô cao hơn nữa
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  productName: product.name,
                                  productPrice: NumberFormat.currency(
                                    locale: 'vi',
                                    symbol: '₫',
                                  ).format(product.price),
                                  imageUrl: '$urlProduct${product.mainImage}',
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
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16),
                                          ),
                                        ),
                                        child: ClipRRect(
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
              ],
>>>>>>> f8e6752157cab7a697e4de6df0b79daad879b980
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: kSubtitleStyle),
          TextButton(
            onPressed: () {},
            child: Text('Xem tất cả', style: TextStyle(color: kTextGray)),
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildCollectionsCarousel() {
    return CarouselSlider.builder(
      itemCount: collections.length,
      itemBuilder: (ctx, idx, _) {
        final col = collections[idx];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(fit: StackFit.expand, children: [
            Image.asset(col.imagePath, fit: BoxFit.cover),
            Positioned(
              bottom: 0, left: 0, right: 0, height: 60,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black45],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12, left: 12,
              child: Text(
                col.title,
                style: kCardTitleStyle.copyWith(color: Colors.white, fontSize: 16),
              ),
            ),
          ]),
        );
      },
      options: CarouselOptions(
        height: 180,
        viewportFraction: 0.6,
        enlargeCenterPage: true,
        padEnds: false,
        enableInfiniteScroll: false,
      ),
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12,
          crossAxisSpacing: 12, childAspectRatio: 0.75,
        ),
        itemBuilder: (ctx, idx) {
          final p = products[idx];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              splashColor: Colors.black12,
              onTap: () {}, // TODO: navigate to detail
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(fit: StackFit.expand, children: [
                      Image.asset(p.imagePath, fit: BoxFit.cover),
                      const Positioned(top: 8, left: 8, child: _NewBadge()),
                      Positioned(
                        top: 8, right: 8,
                        child: AnimatedScale(
                          scale: p.isLiked ? 1.3 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: IconButton(
                            icon: Icon(
                              p.isLiked ? Icons.favorite : Icons.favorite_border,
                              color: p.isLiked ? kAccentRed : kPrimaryBlack,
                            ),
                            onPressed: () => setState(() => p.isLiked = !p.isLiked),
                            splashRadius: 20,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                    child: Text(
                      p.name,
                      style: kCardTitleStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text('${p.price}₫', style: kCardPriceStyle),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundGray,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('JARDO', style: kTitleStyle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: kPrimaryBlack),
            onPressed: _showSearchFilterModal,
          ),
          const SizedBox(width: 16),
          const Icon(Icons.favorite_border, color: kPrimaryBlack),
          const SizedBox(width: 12),
          const Icon(Icons.notifications_none, color: kPrimaryBlack),
          const SizedBox(width: 12),
          const Icon(Icons.shopping_bag_outlined, color: kPrimaryBlack),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Main slider
          CarouselSlider.builder(
            itemCount: sliderImages.length,
            itemBuilder: (ctx, idx, _) => ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                sliderImages[idx],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            options: CarouselOptions(
              height: 260,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              viewportFraction: 0.88,
              onPageChanged: (i, _) => setState(() => _currentSlide = i),
            ),
          ),
          const SizedBox(height: 8),
          // Dot indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(sliderImages.length, (i) {
              final active = i == _currentSlide;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 12 : 8,
                height: active ? 12 : 8,
                decoration: BoxDecoration(
                  color: active ? kPrimaryBlack : Colors.grey[400],
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),

          _buildSectionHeader('Bộ sưu tập mới nhất'),
          const SizedBox(height: 8),
          _buildCollectionsCarousel(),

          _buildSectionHeader('Khám phá sản phẩm'),
          _buildProductGrid(),
        ]),
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: kAccentRed,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2)],
      ),
      child: const Text('Mới', style: TextStyle(color: Colors.white, fontSize: 10)),
    );
  }
}
=======
}
>>>>>>> f8e6752157cab7a697e4de6df0b79daad879b980
