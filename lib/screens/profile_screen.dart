import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/provider.dart'; // Đường dẫn tới UserProvider
import '../screens/theme_provider.dart'; // Đường dẫn tới ThemeProvider

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    print("🟢 [PROFILE] ProfileScreen đang được build");

    return AnimatedBuilder(
      animation: themeProvider,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Hồ sơ"),
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Chức năng chỉnh sửa hồ sơ sắp ra mắt!")),
                  );
                },
              ),
            ],
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 2,
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white // Chữ trắng trong dark mode
                              : Colors.black87, // Chữ đen đậm trong light mode
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white70 // Chữ xám nhạt trong dark mode
                              : Colors.black54, // Chữ xám đậm trong light mode
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildStatsSection(context),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Chế độ tối",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white70 // Chữ xám nhạt trong dark mode
                                  : Colors.black54, // Chữ xám đậm trong light mode
                            ),
                          ),
                          Consumer<ThemeProvider>(
                            builder: (context, themeProvider, child) {
                              return Switch(
                                value: themeProvider.isDarkMode,
                                onChanged: (value) {
                                  themeProvider.toggleTheme();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(context, "5", "Khóa học hoàn thành"),
        _buildStatItem(context, "12", "Giờ học"),
        _buildStatItem(context, "3", "Chứng chỉ"),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white // Chữ trắng trong dark mode
                : Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white70 // Chữ xám nhạt trong dark mode
                : Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Xem danh sách khóa học của bạn")),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 5,
          ),
          child: const Text(
            "Khóa học của tôi",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {
            _showLogoutDialog(context);
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            side: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
          child: Text(
            "Đăng xuất",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.redAccent // Màu đỏ sáng hơn trong dark mode
                  : Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Xác nhận",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white // Chữ trắng trong dark mode
                : Theme.of(context).textTheme.headlineMedium?.color ?? Colors.black87,
          ),
        ),
        content: Text(
          "Bạn có chắc muốn đăng xuất không?",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white70 // Chữ xám nhạt trong dark mode
                : Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black54,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Hủy",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white // Chữ trắng trong dark mode
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              "Đăng xuất",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.redAccent // Màu đỏ sáng hơn trong dark mode
                    : Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).cardColor,
      ),
    );
  }
}