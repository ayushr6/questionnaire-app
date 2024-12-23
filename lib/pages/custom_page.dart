import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showBackButton;

  const CustomPage({
    Key? key,
    required this.title,
    required this.body,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 34, 25, 23), // Almost white (top)
              Color.fromARGB(255, 132, 61, 52), // Deep orange (bottom)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                color: Colors.transparent, // AppBar background color
                child: Row(
                  children: [
                    // Back Button
                    if (showBackButton)
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    if (!showBackButton)
                      const SizedBox(width: 48), // Space for alignment when no back button
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Body Content
              Expanded(
                child: body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
