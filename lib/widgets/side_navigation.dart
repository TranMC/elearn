import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class SideNavigation extends StatelessWidget {
  final Function(int) onSelect;

  const SideNavigation({required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(Icons.home, "Trang chủ", 0, context),
                _buildDrawerItem(Icons.person, "Hồ sơ", 1, context),
                _buildDrawerItem(Icons.class_, "Khoá học", 2, context),
                _buildDrawerItem(Icons.settings, "Cài đặt", 4, context),
                Divider(),
                _buildDrawerItem(Icons.info, "Về chúng tôi", 3, context),
                _buildDrawerItem(
                  Icons.logout,
                  "Đăng xuất",
                  -1,
                  context,
                  isLogout: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 40, bottom: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/drawer_bg.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/images/avatar.png"),
          ),
          SizedBox(height: 10),
          Text(
            "Minh Nguyễn",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "minhnguyen@email.com",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    int index,
    BuildContext context, {
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: () async {
        if (isLogout) {
          _showLogoutDialog(context);
        } else {
          // Gọi callback trước khi đóng drawer
          onSelect(index);
          // Đóng drawer sau đó
          await Future.delayed(Duration(milliseconds: 100));
          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isLogout ? Colors.red : Colors.blue),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Xác nhận"),
            content: Text("Bạn có chắc muốn đăng xuất không?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Hủy"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text("Đăng xuất", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}
