import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobi/config/default.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Widget _buildLogo() {
    return Column(
      children: [
        // Replace with your actual logo asset or widget
        Icon(Icons.account_circle, size: 100, color: Colors.black87),
        const SizedBox(height: 16),
        Text(
          'JARDO',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'EST. 2025',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 2,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Số điện thoại của bạn',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () {},
        child: Text(
          'TIẾP TỤC',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('HOẶC', style: TextStyle(color: Colors.black54)),
        ),
        Expanded(child: Divider(thickness: 1)),
      ],
    );
  }

  Widget _buildSocialButton(
      {required Color color,
      required Widget icon,
      required String text,
      required Color textColor,
      VoidCallback? onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
        ),
        icon: icon,
        label: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildTermsText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text.rich(
        TextSpan(
          text: 'Bằng việc đăng nhập, bạn đã đồng ý với ',
          style: TextStyle(fontSize: 12, color: Colors.black54),
          children: [
            TextSpan(
              text: 'Điều khoản dịch vụ',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
            TextSpan(text: ' & '),
            TextSpan(
              text: 'chính sách bảo mật',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
            TextSpan(text: ' của chúng tôi'),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 32),
                _buildPhoneInput(),
                const SizedBox(height: 16),
                _buildContinueButton(),
                const SizedBox(height: 16),
                _buildDivider(),
                const SizedBox(height: 16),
                _buildSocialButton(
                  color: Colors.black,
                  icon: Icon(Icons.apple, color: Colors.white),
                  text: 'Tiếp tục bằng Apple',
                  textColor: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                _buildSocialButton(
                  color: Color(0xFF1877F3),
                  icon: Icon(Icons.facebook, color: Colors.white),
                  text: 'Tiếp tục bằng Facebook',
                  textColor: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                _buildSocialButton(
                  color: Colors.white,
                  icon: Image.asset(
                    '${urlImg}google_logo.png',
                    height: 24,
                    width: 24,
                  ),
                  text: 'Tiếp tục bằng Google',
                  textColor: Colors.black87,
                  onPressed: () {},
                ),
                const SizedBox(height: 24),
                _buildTermsText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}