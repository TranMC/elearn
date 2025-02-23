import 'package:flutter/material.dart';
import '../widgets/side_navigation.dart';
import '../screens/profile_screen.dart'; // Import ProfileScreen
import '../screens/settings_screen.dart'; // Import SettingsScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình
  final List<Widget> _screens = [
    HomeContent(key: ValueKey(0)), // Trang chính
    ProfileScreen(), // Trang Hồ sơ
    SettingsScreen(), // Trang Cài đặt
    Center(child: Text("ℹ️ Về chúng tôi", style: TextStyle(fontSize: 24))),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/avatar.png',
              ), // Avatar user
            ),
            SizedBox(width: 10),
            Text(
              "Xin chào, Minh!",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
      drawer: SideNavigation(
        onSelect: _onItemTapped,
      ), // Tích hợp Side Navigation
      body: IndexedStack(
        index: _selectedIndex,
        children:
            _screens
                .map(
                  (screen) => Container(
                    key: ValueKey(_screens.indexOf(screen)),
                    child: screen,
                  ),
                )
                .toList(),
      ),
    );
  }
}

// Nội dung chính của trang Home
class HomeContent extends StatelessWidget {
  @override
  final Key? key;

  const HomeContent({this.key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(
      "🟢 [HOME] HomeContent đang được build",
    ); // Kiểm tra xem có hiển thị không
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          _buildSearchBar(),
          SizedBox(height: 20),
          _buildCategorySection(),
          SizedBox(height: 20),
          _buildPopularCourses(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: "Tìm kiếm khóa học...",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.5,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(categories[index]['icon'], color: Colors.blue),
                    SizedBox(width: 10),
                    Text(categories[index]['title']),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularCourses() {
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 15),
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(courses[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      courses[index]['title']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black45,
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
