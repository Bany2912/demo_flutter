import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isFirstStage = true; // true = OTP stage, false = Registration form
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = 
      List.generate(6, (index) => TextEditingController());
  
  // Registration form controllers
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ĐĂNG KÍ'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isFirstStage ? _buildOtpVerification() : _buildRegistrationForm(),
      ),
    );
  }

  Widget _buildOtpVerification() {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Text(
          'Hãy nhập mã OTP được gửi đến số điện thoại +84 000000000',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 45,
              height: 55,
              child: TextField(
                controller: _otpControllers[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style: const TextStyle(fontSize: 24),
                decoration: const InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                onChanged: (value) {
                  if (value.length == 1 && index < 5) {
                    FocusScope.of(context).nextFocus();
                  }
                  if (index == 5 && value.length == 1) {
                    // Verify OTP and proceed to next stage
                    setState(() => isFirstStage = false);
                  }
                },
              ),
            ),
          ),
        ),
        const Spacer(),
        Text.rich(
          TextSpan(
            text: 'Bằng việc đăng nhập, bạn đã đồng ý với ',
            children: [
              TextSpan(
                text: 'Điều khoản dịch vụ',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              const TextSpan(text: ' & '),
              TextSpan(
                text: 'chính sách bảo mật',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              const TextSpan(text: ' của chúng tôi'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Họ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Vui lòng nhập họ';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Vui lòng nhập tên';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _birthDateController,
              decoration: const InputDecoration(
                labelText: 'Ngày sinh',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Vui lòng nhập ngày sinh';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Vui lòng nhập email';
                if (!value!.contains('@')) return 'Email không hợp lệ';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Vui lòng nhập mật khẩu';
                if (value!.length < 6) return 'Mật khẩu phải có ít nhất 6 ký tự';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nhập lại mật khẩu',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Mật khẩu không khớp';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Handle registration completion
                }
              },
              child: const Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    _lastNameController.dispose();
    _firstNameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}