import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/components/custom_profile_button.dart';

class PerfoileView extends StatelessWidget {
  const PerfoileView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Karim Ahmed",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "FlutterDeveloper.karim@gmail.com",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ProfileButton(
                  icon: Icons.person,
                  label: "Edit Name",
                  onPressed: () {
                    // Navigate to edit name screen
                  },
                ),
                const SizedBox(height: 12),
                ProfileButton(
                  icon: Icons.shopping_bag,
                  label: "My Orders",
                  onPressed: () {
                    // Navigate to orders screen
                  },
                ),
                const SizedBox(height: 12),
                ProfileButton(
                  icon: Icons.logout,
                  label: "Logout",
                  onPressed: () {
                    // Logout logic
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}