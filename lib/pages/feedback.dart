import 'package:flutter/material.dart';
import 'package:quiz_app/pages/custom_page.dart';

class ComicFeedbackPage extends StatefulWidget {
  const ComicFeedbackPage({Key? key}) : super(key: key);

  @override
  State<ComicFeedbackPage> createState() => _ComicFeedbackPageState();
}

class _ComicFeedbackPageState extends State<ComicFeedbackPage> {
  int _selectedRating = 0; // To store the selected star rating
  final TextEditingController _commentController = TextEditingController(); // To handle comment input

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "Comic Feedback Poll",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Comic Display
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://i0.wp.com/company.toonsutra.com/wp-content/uploads/2023/07/Archie1.jpg?fit=202%2C300&ssl=1',
                height: 300,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Archie Adventures",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Star Rating Section
            const Text(
              "Rate this comic:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: index < _selectedRating
                        ? Colors.orange
                        : Colors.white70,
                    size: 30,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Comment Box
            const Text(
              "Your feedback:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your comments here...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Handle submission logic here
                final feedback = _commentController.text;
                final rating = _selectedRating;

                if (rating == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please provide a rating!"),
                    ),
                  );
                  return;
                }

                // Clear inputs
                _commentController.clear();
                setState(() {
                  _selectedRating = 0;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Thank you for your feedback!"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose(); // Dispose controller to prevent memory leaks
    super.dispose();
  }
}
