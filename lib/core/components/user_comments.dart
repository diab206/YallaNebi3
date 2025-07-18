import 'package:flutter/material.dart';

class UserComments extends StatelessWidget {
  const UserComments({super.key});

  @override
  Widget build(BuildContext context) {
    final comments = [
      {'username': 'Ahmed', 'comment': 'This is a great post!'},
      {'username': 'Sara', 'comment': 'Thanks for sharing!'},
      {'username': 'Ali', 'comment': 'Looking forward to more content.'},
      
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment['username']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                comment['comment']!,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
            
            ],
          ),
        );
      },
    );
  }
}
