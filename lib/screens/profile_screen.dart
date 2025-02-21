import 'package:flutter/material.dart';


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
