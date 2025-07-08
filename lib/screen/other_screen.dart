import 'package:flutter/material.dart';
import 'login_screen.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Khác')),
      body: Stack(
        children: [
          // Logo mờ phía sau
          Center(
            child: Opacity(
              opacity: 0.07,
              child: Text(
                'J',
                style: TextStyle(
                  fontSize: 260,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 24),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 60, color: Colors.grey[700]),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 140,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      _buildItem(Icons.favorite_border, 'Danh sách yêu thích'),
                      _buildItem(Icons.card_giftcard, 'Kho voucher'),
                      _buildItem(Icons.shopping_bag_outlined, 'Đơn hàng của tôi'),
                      _buildItem(Icons.location_on_outlined, 'Địa chỉ đã lưu'),
                      _buildItem(Icons.help_outline, 'Hỗ trợ'),
                      _buildItem(Icons.phone_outlined, 'Liên hệ'),
                      _buildItem(Icons.settings_outlined, 'Thiết lập tài khoản'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
