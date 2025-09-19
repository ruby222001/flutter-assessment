import 'package:flutter/material.dart';

class PostContainer extends StatelessWidget {
  final String title;
  final String body;
  const PostContainer({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.white54 : Colors.grey.shade300,
        ),
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(body, textAlign: TextAlign.justify),
      ),
    );
  }
}
