import 'package:flutter/material.dart';
import 'package:mobi/screen/favorite_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobi/providers/auth_provider.dart';
import 'login_screen.dart';
import 'package:mobi/screen/user_screen.dart';
import 'contact_screen.dart';
import 'package:mobi/screen/cart_screen.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Khác')),
      body: Stack(
        children: [
          // Logo mờ phía sau
          Center(
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'images/logobackground.png',
                width: 300,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: Consumer<AuthProvider>(
              builder: (context, auth, _) {
                if (auth.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = auth.user;
                return Column(
                  children: [
                    const SizedBox(height: 24),
                    if (user != null) ...[
                      // Hiển thị thông tin người dùng
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        child: Text(
                          '${user.firstName[0]}${user.lastName[0]}',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ] else ...[
                      // Hiển thị nút đăng nhập
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey[700],
                        ),
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
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildItem(
                            Icons.favorite_border,
                            'Danh sách yêu thích',
                            onTap: () {
                              if (auth.user == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Vui lòng đăng nhập để xem danh sách yêu thích'),
                                    action: SnackBarAction(
                                      label: 'Đăng nhập',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                         MaterialPageRoute(builder: (_) => const LoginScreen()),
                                        );
                                      },
                                    ),
                                  ),
                                );
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FavoritesScreen(
                                    userId: auth.user!.id,
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildItem(Icons.card_giftcard, 'Kho voucher'),
                          _buildItem(
                            Icons.shopping_bag_outlined,
                            'Đơn hàng của tôi',
                          ),
                          _buildItem(
                            Icons.location_on_outlined,
                            'Địa chỉ đã lưu',
                          ),
                          _buildItem(
                            Icons.phone_outlined,
                            'Liên hệ',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ContactScreen(title: 'Liên hệ'),
                                ),
                              );
                            },
                          ),
                          _buildItem(
                            Icons.settings_outlined,
                            'Thiết lập tài khoản',
                            onTap: () {
                              if (auth.user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => UserScreen(user: auth.user!),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Vui lòng đăng nhập để xem thông tin tài khoản',
                                    ),
                                    backgroundColor: Colors.redAccent,
                                    duration: Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                          ),
                          if (user != null)
                            _buildItem(
                              Icons.logout,
                              'Đăng xuất',
                              onTap: () async {
                                await context.read<AuthProvider>().logout();
                                if (!mounted) return;
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap ?? () {},
    );
  }
}