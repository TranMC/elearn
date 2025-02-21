import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("🟢 [PROFILE] ProfileScreen đang được build");
    return Scaffold(
      appBar: AppBar(title: Text("Hồ sơ")),
      body: Center(child: Text("👤 Đây là màn hình hồ sơ")),
    );
  }
}
