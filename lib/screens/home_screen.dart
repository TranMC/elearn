import 'package:flutter/material.dart';
import "course_detail.dart";

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