import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const Color kBackgroundGray = Color(0xFFF2F2F2);
const Color kPrimaryBlack   = Colors.black;
const Color kAccentRed      = Colors.red;

final TextStyle kTitleStyle = TextStyle(
  fontSize: 28, fontWeight: FontWeight.bold, color: kPrimaryBlack,
);

final InputDecoration kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  ),
);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey      = GlobalKey<FormState>();
  final _hoCtrl       = TextEditingController();
  final _tenCtrl      = TextEditingController();
  final _dobCtrl      = TextEditingController();
  final _emailCtrl    = TextEditingController();
  final _pwdCtrl      = TextEditingController();
  final _confirmCtrl  = TextEditingController();
  bool _obscurePwd    = true;
  bool _obscureConfirm= true;

  @override
  void dispose() {
    _hoCtrl.dispose();
    _tenCtrl.dispose();
    _dobCtrl.dispose();
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDateOfBirth() async {
    final now = DateTime.now();
    final dob = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (dob != null) {
      _dobCtrl.text = "${dob.day}/${dob.month}/${dob.year}";
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundGray,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryBlack),
        title: Text('Đăng ký', style: kTitleStyle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Họ
              const Text('Họ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _hoCtrl,
                decoration: kInputDecoration.copyWith(hintText: 'Nhập họ'),
                validator: (v) => v!.trim().isEmpty ? 'Vui lòng nhập họ' : null,
              ),
              const SizedBox(height: 16),

              // Tên
              const Text('Tên', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _tenCtrl,
                decoration: kInputDecoration.copyWith(hintText: 'Nhập tên'),
                validator: (v) => v!.trim().isEmpty ? 'Vui lòng nhập tên' : null,
              ),
              const SizedBox(height: 16),

              // Ngày sinh
              const Text('Ngày sinh', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _dobCtrl,
                readOnly: true,
                decoration: kInputDecoration.copyWith(
                  hintText: 'Chọn ngày sinh',
                  suffixIcon: const Icon(Icons.calendar_today, color: kPrimaryBlack),
                ),
                onTap: _pickDateOfBirth,
                validator: (v) => v!.trim().isEmpty ? 'Vui lòng chọn ngày sinh' : null,
              ),
              const SizedBox(height: 16),

              // Email
              const Text('Email', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _emailCtrl,
                decoration: kInputDecoration.copyWith(hintText: 'Nhập email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  final email = v!.trim();
                  if (email.isEmpty) return 'Vui lòng nhập email';
                  final regex = RegExp(r'^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$');
                  return regex.hasMatch(email) ? null : 'Email không hợp lệ';
                },
              ),
              const SizedBox(height: 16),

              // Mật khẩu
              const Text('Mật khẩu', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _pwdCtrl,
                decoration: kInputDecoration.copyWith(
                  hintText: 'Nhập mật khẩu',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePwd ? Icons.visibility_off : Icons.visibility, color: kPrimaryBlack),
                    onPressed: () => setState(() => _obscurePwd = !_obscurePwd),
                  ),
                ),
                obscureText: _obscurePwd,
                validator: (v) => v!.length < 6 ? 'Mật khẩu tối thiểu 6 ký tự' : null,
              ),
              const SizedBox(height: 16),

              // Nhập lại mật khẩu
              const Text('Nhập lại mật khẩu', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _confirmCtrl,
                decoration: kInputDecoration.copyWith(
                  hintText: 'Nhập lại mật khẩu',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, color: kPrimaryBlack),
                    onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                obscureText: _obscureConfirm,
                validator: (v) => v != _pwdCtrl.text ? 'Mật khẩu không khớp' : null,
              ),
              const SizedBox(height: 24),

              // Đăng ký Button (đã fix style)
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryBlack,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Đăng ký', style: TextStyle(color:Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 16),

              // Terms & Privacy
              Text.rich(
                TextSpan(
                  text: 'Bằng việc đăng ký, bạn đã đồng ý với ',
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'Điều khoản dịch vụ',
                      style: const TextStyle(color: kAccentRed),
                      recognizer: TapGestureRecognizer()..onTap = () {/* open link */},
                    ),
                    const TextSpan(text: ' & '),
                    TextSpan(
                      text: 'Chính sách bảo mật',
                      style: const TextStyle(color: kAccentRed),
                      recognizer: TapGestureRecognizer()..onTap = () {/* open link */},
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
