import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = "Minh Nguyễn"; // Giá trị mặc định
  String _email = "minhnguyen@email.com"; // Giá trị mặc định

  String get name => _name;
  String get email => _email;

  void updateUser(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners(); // Thông báo cho các widget đang lắng nghe để cập nhật UI
  }
}