import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _statusMessage = "Click the button to update the database.";

  Future<void> _updateDatabase() async {
    setState(() {
      _statusMessage = "Updating database...";
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:5000/api/comics/bulk-upload"), // Replace with your backend URL
      );

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = "Done! Database updated successfully.";
        });
      } else {
        setState(() {
          _statusMessage =
              "Failed to update database. Please try again later.";
        });
      }
    } catch (error) {
      setState(() {
        _statusMessage = "Error: Unable to connect to the server.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Status Message
            Text(
              _statusMessage,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Update Database Button
            ElevatedButton(
              onPressed: _updateDatabase,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Update Database",
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
}
