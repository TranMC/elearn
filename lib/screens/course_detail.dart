import 'package:flutter/material.dart';
import '';


class CourseDetailScreen extends StatelessWidget {
  final Map<String, String> course;
  
  CourseDetailScreen({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course['title']!)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(course['image']!, height: 250, width: double.infinity, fit: BoxFit.cover),
          SizedBox(height: 20),
          Text(
            course['title']!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('Bắt đầu học'),
          ),
        ],
      ),
    );
  }
}

