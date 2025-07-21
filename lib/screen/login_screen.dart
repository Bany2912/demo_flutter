import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'register_screen.dart';  // import trang đăng ký

const String urlImg          = 'images/';  // dùng cho Google logo
const Color kPrimaryBlack    = Colors.black;
const Color kAccentRed       = Colors.red;
const Color kTextGray        = Colors.grey;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool _isPhoneRegistered(String phone) {
    // TODO: gọi API kiểm tra. 
    // Hiện tại giả định số nào bắt đầu bằng '09' là đã có, còn lại chưa.
    return phone.startsWith('09');
  }

  void _onContinue() {
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty || phone.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số điện thoại hợp lệ')),
      );
      return;
    }

    if (_isPhoneRegistered(phone)) {
      // TODO: chuyển sang màn OTP hoặc home
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Số $phone đã đăng ký, chuyển sang OTP...')),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => RegisterScreen( )),
      );
    }
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

                // Logo
                const Icon(Icons.account_circle, size: 100, color: Colors.black87),
                const SizedBox(height: 16),
                const Text('JARDO',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.black87,
                    )),
                const SizedBox(height: 4),
                const Text('EST. 2025',
                    style: TextStyle(
                      fontSize: 16, letterSpacing: 2, color: Colors.black54,
                    )),

                const SizedBox(height: 32),

                // Input số điện thoại
                TextField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Số điện thoại của bạn',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),

                const SizedBox(height: 16),

                // Continue button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: _onContinue,
                    child: const Text(
                      'TIẾP TỤC',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Divider
                Row(children: [
                  const Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child:
                        Text('HOẶC', style: TextStyle(color: kTextGray)),
                  ),
                  const Expanded(child: Divider(thickness: 1)),
                ]),

                const SizedBox(height: 16),

                // Social login
                _buildSocialButton(
                  color: Colors.black,
                  icon: const Icon(Icons.apple, color: Colors.white),
                  text: 'Tiếp tục bằng Apple',
                  textColor: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                _buildSocialButton(
                  color: const Color(0xFF1877F3),
                  icon: const Icon(Icons.facebook, color: Colors.white),
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

                // Terms
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'Bằng việc đăng nhập, bạn đã đồng ý với ',
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                      children: const [
                        TextSpan(
                          text: 'Điều khoản dịch vụ',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                        TextSpan(text: ' & '),
                        TextSpan(
                          text: 'chính sách bảo mật',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                        TextSpan(text: ' của chúng tôi'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required Color color,
    required Widget icon,
    required String text,
    required Color textColor,
    VoidCallback? onPressed,
  }) {
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
            color: textColor, fontWeight: FontWeight.w600, fontSize: 16,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
