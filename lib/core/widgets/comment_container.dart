import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/utils/app_spacing.dart';

class CommentContainer extends StatelessWidget {
  final String name;
  final String email;
  final String body;
  const CommentContainer({
    super.key,
    required this.name,
    required this.email,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDarkMode ? Colors.grey : Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: isDarkMode ? Colors.black45 : Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(Icons.person_2_sharp),
                  ),
                ),
                AppSpacing.w5,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(email),
                    ],
                  ),
                ),
              ],
            ),
            Text(body),
          ],
        ),
      ),
    );
  }
}
