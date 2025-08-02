import 'package:flutter/material.dart';
import 'package:mobi/config/default.dart';
import 'package:mobi/models/product.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:mobi/providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ShoeProduct product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ShoeVariant? selectedVariant;
  String? selectedSize;
  int currentImageIndex = 0;
  int quantity = 1;
  bool _isAddingToCart = false;

  final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    selectedVariant = widget.product.variants.isNotEmpty ? widget.product.variants.first : null;
  }

  void _updateQuantity(bool increase) {
    setState(() {
      if (increase && quantity < 10) {
        quantity++;
      } else if (!increase && quantity > 1) {
        quantity--;
      }
    });
  }

  Future<void> _addToCart() async {
    if (_isAddingToCart || selectedVariant == null || selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn phiên bản và kích cỡ')),
      );
      return;
    }

    final inStockSizes = selectedVariant!.sizes.map((s) => s.size).toSet();
    if (!inStockSizes.contains(selectedSize)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kích cỡ này hiện không có sẵn')),
      );
      return;
    }

    setState(() => _isAddingToCart = true);

    try {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      await cartProvider.addToCart(
        widget.product,
        selectedVariant!,
        selectedSize!,
        quantity: quantity,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã thêm $quantity ${widget.product.name} vào giỏ hàng'),
          action: SnackBarAction(
            label: 'XEM GIỎ HÀNG',
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isAddingToCart = false);
      }
    }
  }

  Widget _buildImageGallery() {
    final List<String> images = [
      selectedVariant!.imageUrl,
      ...selectedVariant!.additionalImages,
    ];

    return Column(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/product/${images[currentImageIndex]}',
              height: 300,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => _buildImageError(300),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: images.asMap().entries.map((entry) {
              return _buildThumbnail(entry.key, entry.value);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildThumbnail(int index, String imageName) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () => setState(() => currentImageIndex = index),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: currentImageIndex == index ? Colors.black : Colors.grey[300]!,
              width: currentImageIndex == index ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.asset(
              'assets/images/product/$imageName',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildImageError(80),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageError(double size) {
    return Container(
      height: size,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }

  Widget _buildVariantOption(ShoeVariant variant) {
    final isSelected = selectedVariant?.id == variant.id;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () => setState(() {
          selectedVariant = variant;
          selectedSize = null;
          currentImageIndex = 0;
        }),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
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
              errorBuilder: (_, __, ___) => _buildImageError(80),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVariantOptionRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Phiên bản:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.product.variants.map(_buildVariantOption).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSizeSelector() {
    final inStockSizes = selectedVariant?.sizes.map((s) => s.size).toSet() ?? {};
    final availableSizes = List.generate(11, (i) => (36 + i).toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Size:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Text(
          inStockSizes.isNotEmpty
              ? "Còn ${inStockSizes.length} sản phẩm"
              : "Không có kích cỡ nào có sẵn",
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableSizes.map((size) {
            final isAvailable = inStockSizes.contains(size);
            final isSelected = selectedSize == size;

            return GestureDetector(
              onTap: isAvailable ? () => setState(() => selectedSize = size) : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.white,
                  border: Border.all(
                    color: isAvailable ? Colors.grey : Colors.grey[400]!,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Colors.white : (isAvailable ? Colors.black : Colors.grey[600]),
                    decoration: isAvailable ? null : TextDecoration.lineThrough,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return ClipOval(
      child: Material(
        color: Colors.grey[200],
        child: IconButton(
          icon: Icon(icon, color: Colors.black),
          onPressed: onPressed,
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (selectedVariant == null) {
      return const Scaffold(
        body: Center(child: Text('Không có sản phẩm')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                   Row(
                    children: [
                      Text(
                        'Mã sản phẩm: ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.product.id,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildVariantOptionRow(),
                  Row(
                    children: [
                      Text(
                        'Phiên bản: ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        selectedVariant?.id ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Size: ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        selectedSize ?? 'Chưa chọn size',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _currencyFormatter.format(widget.product.price),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (selectedVariant?.sizes.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Còn ${selectedVariant!.sizes.length} sản phẩm',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Text(
                    'CHỌN KÍCH CỠ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSizeSelector(),
                  const SizedBox(height: 24),
                  const Text(
                    'THÔNG TIN CHI TIẾT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.product.description ?? 'Không có mô tả',
                    style: TextStyle(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text(
                        'Số lượng:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          _buildQuantityButton(
                            Icons.remove,
                            () => _updateQuantity(false),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          _buildQuantityButton(
                            Icons.add,
                            () => _updateQuantity(true),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      _buildInfoRow(
                        Icons.local_shipping_outlined,
                        'MIỄN PHÍ GIAO HÀNG TOÀN QUỐC',
                        'Giao hàng từ 3-5 ngày',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        Icons.refresh,
                        'ĐỔI TRẢ DỄ DÀNG',
                        'Đổi trả trong vòng 30 ngày nếu không vừa size',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        Icons.support_agent,
                        'TỔNG ĐÀI BÁN HÀNG 1800 9999',
                        'Hỗ trợ từ 8:00 - 21:00',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _isAddingToCart ? null : _addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isAddingToCart
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'THÊM VÀO GIỎ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}