import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cài đặt ứng dụng')),
      body: Center(child: Text('Cấu hình các cài đặt trong ứng dụng tại đây.')),
    );
  }
}
