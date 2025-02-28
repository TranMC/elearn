import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../widgets/side_navigation.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/course_detail.dart';
import '../screens/provider.dart';
import '../screens/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(key: ValueKey(0)),
    const ProfileScreen(),
    const SettingsScreen(),
    const Center(child: Text("ℹ️ Về chúng tôi", style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    if (!mounted) return;
    if (index < _screens.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _logout() {
    // TODO: Viết logic đăng xuất sau
    print("User logged out");
  }

  @override
  Widget build(BuildContext context) {
    print("🟡 [BUILD] Hiển thị màn hình có index: $_selectedIndex");
    return AnimatedBuilder(
      animation: Provider.of<ThemeProvider>(context, listen: true),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,
            title: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(width: 10),
                Consumer<UserProvider>(
                  builder: (context, user, child) {
                    return Text(
                      "Xin chào, ${user.name}!",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // Chữ trắng trong dark mode
                            : Theme.of(context).textTheme.titleLarge?.color ?? Colors.black,
                        fontSize: 18,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          drawer: SideNavigation(
            onSelect: _onItemTapped,
          ),
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens.map((screen) => Container(
              key: ValueKey(_screens.indexOf(screen)),
              child: screen,
            )).toList(),
          ),
        );
      },
    );
  }
}

// Nội dung chính của trang Home
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    print("🟢 [HOME] HomeContent đang được build");
    return AnimatedBuilder(
      animation: Provider.of<ThemeProvider>(context, listen: true),
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildSearchBar(context),
              const SizedBox(height: 20),
              _buildAnimatedTitle(context),
              const SizedBox(height: 20),
              _buildCategorySection(context),
              const SizedBox(height: 20),
              _buildPopularCourses(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[700] // Xám đậm trong dark mode
            : Colors.grey[200], // Xám nhạt trong light mode
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black26 // Bóng đen trong dark mode
                : Colors.grey.withOpacity(0.3), // Bóng xám trong light mode
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          hintText: "Tìm kiếm khóa học...",
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildAnimatedTitle(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(
          'Khám phá các khóa học hấp dẫn!',
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white // Chữ trắng trong dark mode
                : Theme.of(context).textTheme.headlineMedium?.color ?? Colors.black,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 1000),
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"title": "Lập trình", "icon": Icons.code},
      {"title": "Thiết kế", "icon": Icons.brush},
      {"title": "Marketing", "icon": Icons.campaign},
      {"title": "Kinh doanh", "icon": Icons.business},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Danh mục",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white // Chữ trắng trong dark mode
                : Theme.of(context).textTheme.headlineMedium?.color ?? Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.5,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: () {
                  // TODO: Thêm logic khi nhấn vào danh mục
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]?.withOpacity(0.3) // Nền xám đậm trong dark mode
                        : Colors.blueAccent.withOpacity(0.1), // Nền xanh nhạt trong light mode
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white24 // Viền xám nhạt trong dark mode
                          : Colors.blueAccent.withOpacity(0.3), // Viền xanh nhạt trong light mode
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        categories[index]['icon'],
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // Icon trắng trong dark mode
                            : Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        categories[index]['title'],
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white // Chữ trắng trong dark mode
                              : Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularCourses(BuildContext context) {
    final List<Map<String, String>> courses = [
      {
        "title": "Flutter cho người mới",
        "image": "assets/images/flutter_course.jpg",
      },
      {"title": "Thiết kế UI/UX", "image": "assets/images/uiux_course.jpg"},
      {
        "title": "Kinh doanh Online",
        "image": "assets/images/business_course.jpg",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Khóa học phổ biến",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white // Chữ trắng trong dark mode
                : Theme.of(context).textTheme.headlineMedium?.color ?? Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 15),
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(courses[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black26 // Bóng đen trong dark mode
                          : Colors.grey.withOpacity(0.3), // Bóng xám trong light mode
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailScreen(
                          course: courses[index],
                        ),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        courses[index]['title']!,
                        style: TextStyle(
                          color: Colors.white, // Giữ màu trắng cho chữ trên hình ảnh
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}