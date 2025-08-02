import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  final String title; // Named parameter for the screen title

  // Constructor with a named parameter
  const ContactScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
        title: Text(title), // Use the passed title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Đặt hàng online',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Tất cả các ngày trong tuần - từ T7 đến T2'),
            Text('08:30 - 20:30'),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 8),
                Text('1800 0000'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Góp ý & khiếu nại',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Tất cả các ngày trong tuần - từ T7 đến T2'),
            Text('08:30 - 20:30'),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 8),
                Text('1800 0000'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 8),
                Text('cskh@jardo.vn'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Địa chỉ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 8),
                Text('313 Nguyễn An ABC, Phường C, Quận 0, TP.HCM'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}