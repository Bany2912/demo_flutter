import 'package:flutter/material.dart';
import 'package:mobi/config/default.dart';
import 'package:mobi/screen/home_screen.dart'; // Đảm bảo đúng đường dẫn file home_screen.dart
import 'package:mobi/screen/shopping_screen.dart'; // Đảm bảo đúng đường dẫn
import 'package:mobi/screen/other_screen.dart'; // Đảm bảo đúng đường dẫn

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const CartScreen(), // Đổi tên ShoppingScreen thành CartScreen theo code cũ nếu bạn giữ nguyên
    const OtherScreen(),
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: clBackground,

        
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white.withOpacity(0.5), 
          elevation: 0, 
          shadowColor: Colors.transparent, 
          surfaceTintColor: Colors.transparent, 
          iconTheme: const IconThemeData(color: Colors.black), 
          actionsIconTheme: const IconThemeData(color: Colors.black), 
         
          titleTextStyle: titleStyle.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
            color: Colors.black,
          ),
          toolbarTextStyle: const TextTheme( // Kiểu chữ cho các văn bản khác trong toolbar (nếu có)
            titleLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.0,
              color: Colors.black,
            ),
          ).titleLarge, // Đảm bảo sử dụng TextStyle phù hợp
        ),
        
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: clBackground,
          selectedItemColor: Colors.grey[800],
          unselectedItemColor: Colors.grey[500],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          type: BottomNavigationBarType.fixed,
        ),
      ),
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
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}