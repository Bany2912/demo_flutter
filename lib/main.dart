import 'package:flutter/material.dart';
import 'package:mobi/screen/home_screen.dart';
import 'package:mobi/screen/cart_screen.dart';
import 'package:mobi/screen/other_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0; // Chỉ số trang hiện tại

  // Danh sách các trang
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
    OtherScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng của bạn',
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Mua sắm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'Khác',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.grey[800], // Màu khi chọn
          unselectedItemColor: Colors.grey[500], // Màu khi không chọn
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}