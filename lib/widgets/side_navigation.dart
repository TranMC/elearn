import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';
import '../screens/course_detail.dart';
import '../screens/provider.dart'; 



class SideNavigation extends StatelessWidget {
  final Function(int) onSelect;

  const SideNavigation({required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(Icons.home, "Trang chủ", 0, context),
                _buildDrawerItem(Icons.person, "Hồ sơ", 1, context),
                _buildCourseItem(context),
                _buildDrawerItem(Icons.settings, "Cài đặt", 2, context),
                _buildDrawerItem(Icons.info, "Về chúng tôi", 3, context),
                const Divider(),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/drawer_bg.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
        color: Theme.of(context).scaffoldBackgroundColor, // Tự động theo theme
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/images/avatar.png"),
          ),
          const SizedBox(height: 10),
          Consumer<UserProvider>( // Sử dụng UserProvider để hiển thị tên
            builder: (context, user, child) {
              return Text(
                user.name,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.headlineMedium?.color ?? Colors.white, // Màu chữ theo theme
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          Consumer<UserProvider>( // Sử dụng UserProvider để hiển thị email
            builder: (context, user, child) {
              return Text(
                user.email,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white70, // Màu chữ theo theme
                ),
              );
            },
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
      onTap: () {
        if (isLogout) {
          _showLogoutDialog(context);
        } else {
          onSelect(index);
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]?.withOpacity(0.3) // Màu nền tối trong Dark Mode
              : Colors.blue.withOpacity(0.1), // Màu nền sáng trong Light Mode
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout
                  ? Theme.of(context).colorScheme.error // Màu đỏ cho Đăng xuất, theo theme
                  : Theme.of(context).primaryColor, // Màu chính theo theme
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyMedium?.color, // Màu chữ theo theme
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItem(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CourseDetailScreen(
              course: {
                'title': 'Flutter cho người mới',
                'image': 'https://example.com/flutter_course.jpg',
              },
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]?.withOpacity(0.3) // Màu nền tối trong Dark Mode
              : Colors.blue.withOpacity(0.1), // Màu nền sáng trong Light Mode
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.class_,
              color: Theme.of(context).primaryColor, // Màu icon theo theme
            ),
            const SizedBox(width: 10),
            Text(
              "Khóa học",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyMedium?.color, // Màu chữ theo theme
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Xác nhận", style: TextStyle(color: Theme.of(context).textTheme.headlineMedium?.color)),
        content: Text("Bạn có chắc muốn đăng xuất không?", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Hủy", style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Text("Đăng xuất", style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
        backgroundColor: Theme.of(context).cardColor, // Màu nền dialog theo theme
      ),
    );
  }
}