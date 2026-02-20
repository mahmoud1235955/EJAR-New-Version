import 'package:ejar/core/colors/app_color.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        itemCount: 10, // تجريبي
        separatorBuilder: (context, index) =>
            const Divider(indent: 80, height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage("assets/images/user_placeholder.png"),
            ),
            title: const Text(
              "Ahmed Mohamed",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              "Is the apartment still available?",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "12:30 PM",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.primary,
                  child: const Text(
                    "2",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ],
            ),
            onTap: () {
              // الانتقال لشاشة المحادثة التفصيلية
            },
          );
        },
      ),
    );
  }
}
