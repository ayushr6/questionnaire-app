import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/widgets/title_bar.dart';
import 'package:quiz_app/pages/settings.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0; // Track the selected index

  // List of pages
  final List<Widget> _pages = [
    HomePage(),
    Center(child: Text("Favorite Page", style: TextStyle(fontSize: 20, color: Colors.white))),
    const SettingsPage(),
  ];

  // List of page titles
  final List<String> _titles = ["Home Page", "Favorite Page", "Settings Page"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 34, 25, 23),
        color: Colors.white,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
        items: const [
          Icon(Icons.home, color: Color.fromARGB(255, 132, 61, 52)),
          Icon(Icons.favorite, color: Color.fromARGB(255, 132, 61, 52)),
          Icon(Icons.settings, color: Color.fromARGB(255, 132, 61, 52)),
        ],
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
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
          ),
          // Page Content with Top Bar
          Column(
            children: [
              // Top Bar
              TitleBar(title: _titles[_selectedIndex]), // Use the TitleBar from title_bar.dart
              // Page Content
              Expanded(child: _pages[_selectedIndex]),
            ],
          ),
        ],
      ),
    );
  }
}
