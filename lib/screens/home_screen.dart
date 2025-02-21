import 'package:flutter/material.dart';
import '../widgets/side_navigation.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Danh sách màn hình
  final List<Widget> _screens = [
    Center(child: Text("🏡 Home Screen", style: TextStyle(fontSize: 24))),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Đóng menu sau khi chọn
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter App")),
      drawer: SideNavigation(onSelect: _onItemTapped),
      body: _screens[_selectedIndex],
    );
  }
}
