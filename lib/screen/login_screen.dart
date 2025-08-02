import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'register_screen.dart';  // import trang đăng ký
import 'password_screen.dart';  // import trang đăng nhập bằng mật khẩu
import '../getdata/user_data.dart'; // import UserData

const String urlImg          = 'images/';  // dùng cho Google logo
const Color kPrimaryBlack    = Colors.black;
const Color kAccentRed       = Colors.red;
const Color kTextGray        = Colors.grey;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty || phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số điện thoại hợp lệ')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final users = await UserData.getUsers();
      final isRegistered = users.any((user) => user.phoneNumber == phone);

      if (!mounted) return;

      if (isRegistered) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PasswordScreen(phoneNumber: phone),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RegisterScreen(phoneNumber: phone),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã có lỗi xảy ra')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
                Image.asset(
                  '${urlImg}logo.png',
                  height: 400,
                  width: 400,
                ),
               
                const SizedBox(height: 27),

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
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
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

class RegisterScreen extends StatelessWidget {
  final String phoneNumber;

  const RegisterScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký'),
      ),
      body: Center(
        child: Text('Register screen for $phoneNumber'),
      ),
    );
  }
}
