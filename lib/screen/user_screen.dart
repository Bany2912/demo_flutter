import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobi/models/user.dart'; // <-- Thêm nếu chưa có
import 'package:provider/provider.dart';
import 'package:mobi/providers/auth_provider.dart';
import 'package:mobi/screen/login_screen.dart';

class UserScreen extends StatefulWidget {
  final User user; // <-- Nhận user từ ngoài

  const UserScreen({super.key, required this.user}); // <-- Sửa constructor

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _birthDateCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _birthDateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user; // <-- Lấy user từ widget

    // Gán giá trị mặc định cho controller
    _firstNameCtrl.text = user.firstName;
    _lastNameCtrl.text = user.lastName;
    _emailCtrl.text = user.email;
    _phoneCtrl.text = user.phoneNumber;
    _birthDateCtrl.text = DateFormat('dd/MM/yyyy').format(user.birthDate);

    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin cá nhân')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 24),
            TextField(
              controller: _firstNameCtrl,
              decoration: const InputDecoration(
                labelText: 'Họ',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameCtrl,
              decoration: const InputDecoration(
                labelText: 'Tên',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(
                labelText: 'Số điện thoại',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _birthDateCtrl,
              decoration: const InputDecoration(
                labelText: 'Ngày sinh',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  await context.read<AuthProvider>().logout();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'ĐĂNG XUẤT',
                  style: TextStyle(
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
}
