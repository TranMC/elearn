import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ElearningApp());
}

class ElearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [HomeScreen(), ProfileScreen(), SettingsScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Khóa học'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hồ sơ'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> courses = [
    {'title': 'Flutter Cơ Bản', 'image': 'https://via.placeholder.com/300'},
    {'title': 'React Native Nâng Cao', 'image': 'https://via.placeholder.com/300'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khóa Học'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/50'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => CourseDetailScreen(course: courses[index]),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              ),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 4,
                shadowColor: Colors.blueAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.network(courses[index]['image']!, height: 140, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        courses[index]['title']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hồ sơ cá nhân')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/100'),
            ),
            SizedBox(height: 10),
            Text('Người dùng 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('user@email.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cài đặt ứng dụng')),
      body: Center(child: Text('Cấu hình các cài đặt trong ứng dụng tại đây.')),
    );
  }
}
