import 'package:flutter/material.dart';
import 'package:quiz_app/pages/feedback.dart';
import 'package:quiz_app/pages/find_your_genre.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent to show Wrapper background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              const Text(
                "Welcome to the Toonsutra Universe!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Explore surveys and games to discover your favorite comics.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),

              // Example Content
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    // Example Feature Card
                    _buildFeatureCard(
                      context,
                      title: "Comic Feedback Poll",
                      description: "Share your thoughts on Toonsutra comics.",
                      icon: Icons.poll,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComicFeedbackPage(),
                          ),
                        );
                      },
                    ),
                    _buildFeatureCard(
                      context,
                      title: "Find Your Favorite Genre",
                      description: "Discover genres that match your preferences.",
                      icon: Icons.category,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FindGenrePage(),
                          ),
                        );
                      },
                    ),
                    _buildFeatureCard(
                      context,
                      title: "Your Comic Character Match",
                      description: "Find the character that matches you best!",
                      icon: Icons.person,
                      onTap: () {
                        // Navigate to Character Match Page
                      },
                    ),
                    _buildFeatureCard(
                      context,
                      title: "Find a Comic to Read",
                      description: "Get personalized comic recommendations.",
                      icon: Icons.book,
                      onTap: () {
                        // Navigate to Comic Recommendation Page
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Feature Card Builder
  Widget _buildFeatureCard(BuildContext context,
      {required String title,
      required String description,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white.withOpacity(0.1), // Transparent card
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: const Color(0xFFFF6A00), // Custom orange color
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
