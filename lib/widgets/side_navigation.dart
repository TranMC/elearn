import 'package:flutter/material.dart';

class SideNavigation extends StatelessWidget {
  final Function(int) onSelect;

  const SideNavigation({required this.onSelect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, "Home", 0),
          _buildDrawerItem(Icons.person, "Profile", 1),
          _buildDrawerItem(Icons.settings, "Settings", 2),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => onSelect(index),
    );
  }
}
