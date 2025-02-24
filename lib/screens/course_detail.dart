import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final Map<String, String> course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar với hình ảnh khóa học
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                course['title']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Đảm bảo tiêu đề luôn trắng để dễ đọc trên nền tối
                  shadows: const [Shadow(color: Colors.black45, blurRadius: 5)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    course['image']!,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.dstATop, // Tăng độ tương phản cho hình ảnh trong dark mode
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.2)
                        : null,
                  ),
                  // Gradient overlay để tiêu đề nổi bật
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900] // Nền tối hơn cho dark mode
                : Theme.of(context).appBarTheme.backgroundColor,
          ),
          // Nội dung chi tiết
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề (dự phòng khi cuộn hết SliverAppBar)
                  Text(
                    course['title']!,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white // Chữ trắng trong dark mode
                          : Colors.black87, // Chữ đen đậm trong light mode
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Đánh giá và số lượng học viên
                  Row(
                    children: [
                      Icon(Icons.star,
                          color: Colors.yellow, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        "4.8 (1,234 đánh giá)",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white70 // Chữ xám nhạt trong dark mode
                              : Colors.grey, // Chữ xám trong light mode
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "5,678 học viên",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white70 // Chữ xám nhạt trong dark mode
                              : Colors.grey[600], // Chữ xám đậm trong light mode
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Mô tả khóa học
                  Text(
                    "Mô tả khóa học",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white // Chữ trắng trong dark mode
                          : Colors.black87, // Chữ đen đậm trong light mode
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Khóa học ${course['title']} sẽ giúp bạn nắm vững các kỹ năng từ cơ bản đến nâng cao, được thiết kế dành cho cả người mới bắt đầu và những ai muốn nâng cao kiến thức.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70 // Chữ xám nhạt trong dark mode
                          : Colors.black54, // Chữ xám đậm trong light mode
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Thông tin bổ sung
                  _buildInfoRow(context, Icons.person, "Giảng viên: Nguyễn Văn A"),
                  _buildInfoRow(context, Icons.timer, "Thời lượng: 12 giờ"),
                  _buildInfoRow(context, Icons.book, "Bài học: 25 bài"),
                  const SizedBox(height: 30),
                  // Nút hành động
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị thông tin bổ sung
  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white // Icon trắng trong dark mode
                  : Colors.blueAccent, // Icon xanh trong light mode
              size: 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70 // Chữ xám nhạt trong dark mode
                  : Colors.black87, // Chữ đen đậm trong light mode
            ),
          ),
        ],
      ),
    );
  }

  // Widget nút hành động
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Bắt đầu học ngay!")),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueAccent // Giữ màu xanh nhưng đảm bảo tương phản tốt
                  : Colors.blueAccent,
              elevation: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.play_arrow, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Bắt đầu học",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Đã thêm vào danh sách yêu thích")),
            );
          },
          icon: Icon(Icons.favorite_border, size: 30),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.redAccent // Màu đỏ sáng hơn trong dark mode
              : Colors.redAccent,
        ),
      ],
    );
  }
}