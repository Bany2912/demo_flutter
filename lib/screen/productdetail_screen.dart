import 'package:flutter/material.dart';
import 'package:mobi/models/product.dart'; // Đảm bảo đường dẫn này đúng
import 'package:intl/intl.dart'; // Import để định dạng tiền tệ

class ProductDetailScreen extends StatefulWidget {
  final ShoeProduct product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // Loại bỏ 'late' khỏi selectedVariant. Chúng ta sẽ khởi tạo nó trong initState
  // hoặc gán một giá trị mặc định an toàn.
  ShoeVariant? selectedVariant; // Đặt là nullable để có thể gán null ban đầu
  String? selectedSize;
  int currentImageIndex = 0;

  final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    // Đảm bảo widget.product không null và có variants
    if (widget.product.variants.isNotEmpty) {
      selectedVariant = widget.product.variants.first;
      selectedSize = null; // Không chọn size mặc định
      currentImageIndex = 0; // Reset index ảnh khi chọn variant mới
    } else {
      // Trường hợp không có biến thể nào
      // Khởi tạo selectedVariant với một giá trị an toàn/placeholder
      selectedVariant = ShoeVariant(
        id: 'default_variant',
        colorName: 'Không có biến thể',
        colorCode: '#CCCCCC',
        imageUrl: 'placeholder.png', // Hãy đảm bảo bạn có một ảnh placeholder trong assets
        additionalImages: [],
        sizes: [],
      );
      // Hiển thị SnackBar sau khi frame đầu tiên được render
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sản phẩm này hiện không có biến thể nào để hiển thị.'),
            backgroundColor: Colors.orange,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nếu selectedVariant vẫn là null (trường hợp cực kỳ hiếm nếu initState an toàn)
    // hoặc bạn muốn thêm một loading/error state ở đây.
    if (selectedVariant == null) {
      return  Scaffold(
        appBar: AppBar(title: Text('Chi tiết sản phẩm')),
        body: Center(child: Text('Không thể tải chi tiết sản phẩm hoặc không có biến thể.')),
      );
    }

    final availableSizes = List.generate(11, (i) => (36 + i).toString());
    // Đảm bảo selectedVariant.sizes không null trước khi gọi map
    final inStockSizes = selectedVariant!.sizes.map((s) => s.size).toSet(); // Sử dụng '!' vì đã kiểm tra null ở trên

    // Tạo danh sách tất cả ảnh của variant hiện tại
    final List<String> currentVariantImages = [];
    currentVariantImages.add(selectedVariant!.imageUrl); // Sử dụng '!'
    currentVariantImages.addAll(selectedVariant!.additionalImages); // Sử dụng '!'

    // Lấy ảnh chính hiện tại để hiển thị
    String mainDisplayImageUrl = currentVariantImages.isNotEmpty
        ? currentVariantImages[currentImageIndex]
        : 'placeholder.png';

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.shopping_bag_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh chính (main)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/product/$mainDisplayImageUrl',
                  height: 300,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    print('Lỗi tải ảnh chính ($mainDisplayImageUrl): $error');
                    return Container(
                      height: 300,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error, color: Colors.red, size: 40),
                            SizedBox(height: 8),
                            Text('Không thể tải ảnh chính', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Tên sản phẩm và giá
            Text(
              widget.product.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              _currencyFormatter.format(widget.product.price),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            // PHẦN HIỂN THỊ CÁC THUMBNAIL ẢNH CHI TIẾT CỦA VARIANT HIỆN TẠI
            if (currentVariantImages.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Ảnh chi tiết:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: currentVariantImages.asMap().entries.map((entry) {
                        int idx = entry.key;
                        String imgName = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentImageIndex = idx; // Cập nhật index ảnh để thay đổi ảnh chính
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: currentImageIndex == idx
                                      ? Colors.black // Border đen khi được chọn
                                      : Colors.grey[300]!,
                                  width: currentImageIndex == idx ? 2 : 1, // Dày hơn khi được chọn
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: Image.asset(
                                  'assets/images/product/$imgName',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Lỗi tải thumbnail ($imgName): $error');
                                    return Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey[200],
                                      child: const Center(child: Icon(Icons.broken_image, size: 30)),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Không có ảnh chi tiết nào cho phiên bản này.',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600]),
                ),
              ),

            const SizedBox(height: 20),

            // PHẦN CHỌN VARIANT (MÀU SẮC/KIỂU DÁNG)
            const Text("Phiên bản:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.product.variants.map((variant) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedVariant = variant; // Cập nhật variant đã chọn
                          selectedSize = null; // Đặt lại size về null khi đổi variant
                          currentImageIndex = 0; // Reset lại ảnh chính về ảnh đầu tiên của variant mới
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedVariant!.id == variant.id // Sử dụng '!'
                                ? Colors.blueAccent
                                : Colors.grey[300]!,
                            width: selectedVariant!.id == variant.id ? 2 : 1, // Sử dụng '!'
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.asset(
                            'assets/images/product/${variant.imageUrl}',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print('Lỗi tải ảnh đại diện variant (${variant.imageUrl}): $error');
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[200],
                                child: const Center(child: Icon(Icons.broken_image, size: 30)),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // Kích cỡ
            const Text("Size:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(
                inStockSizes.isNotEmpty
                    ? "Còn ${inStockSizes.length} sản phẩm"
                    : "Không có kích cỡ nào có sẵn",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: availableSizes.map((size) {
                final isAvailable = inStockSizes.contains(size);
                return GestureDetector(
                  onTap: isAvailable
                      ? () {
                          setState(() {
                            selectedSize = size;
                          });
                          print('Chọn kích cỡ: $size');
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedSize == size
                          ? Colors.black
                          : Colors.white,
                      border: Border.all(
                        color: isAvailable ? Colors.grey : Colors.grey[400]!,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: selectedSize == size
                            ? Colors.white
                            : (isAvailable ? Colors.black : Colors.grey[600]),
                        decoration: isAvailable ? null : TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Số lượng
            const Text("Số lượng:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.remove, size: 20), onPressed: () {}),
                  const Text("1", style: TextStyle(fontSize: 16)),
                  IconButton(icon: const Icon(Icons.add, size: 20), onPressed: () {}),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Các thông tin bổ sung
            buildInfoRow(
              icon: Icons.local_shipping,
              title: "MIỄN PHÍ GIAO HÀNG TOÀN QUỐC",
              description: "Miễn phí vận chuyển cho đơn hàng từ 499.000₫",
            ),
            const Divider(height: 20, thickness: 1, color: Colors.grey),

            buildInfoRow(
              icon: Icons.refresh,
              title: "ĐỔI TRẢ DỄ DÀNG",
              description: "Đổi trả 30 ngày cho khách hàng nếu không vừa size hoặc lỗi do nhà sản xuất",
            ),
            const Divider(height: 20, thickness: 1, color: Colors.grey),

            buildInfoRow(
              icon: Icons.phone,
              title: "TỔNG ĐÀI BÁN HÀNG 1800 9999",
              description: "(Miễn phí từ 8:00 - 21:00 mỗi ngày)",
            ),
            const Divider(height: 20, thickness: 1, color: Colors.grey),

            // Thông tin chi tiết sản phẩm (description)
            const Text("Thông tin chi tiết sản phẩm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(widget.product.description, style: const TextStyle(fontSize: 14, height: 1.5)),
            TextButton(
              onPressed: () {
                print("Xem đầy đủ mô tả");
              },
              child: const Text("XEM ĐẦY ĐỦ", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              if (selectedSize == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng chọn kích cỡ.'), backgroundColor: Colors.orange),
                );
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã thêm ${widget.product.name} - Size $selectedSize vào giỏ hàng!')),
              );
              print('Thêm vào giỏ hàng: ${widget.product.name}, Size: $selectedSize, Màu: ${selectedVariant!.colorName}'); // Sử dụng '!'
            },
            icon: const Icon(Icons.add_shopping_cart, size: 24),
            label: const Text("Thêm vào giỏ hàng", style: TextStyle(fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow({required IconData icon, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 34.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}