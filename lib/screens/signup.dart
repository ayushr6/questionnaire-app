import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/background_container.dart';
import 'package:quiz_app/screens/signin.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          const BackgroundContainer(),

          // Sign-Up Form
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  ClipOval(
                    child: Image.network(
                      'https://scontent.fjai1-2.fna.fbcdn.net/v/t39.30808-6/302530852_460829472765777_7355018370173241938_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=Fw_za3hzhggQ7kNvgFHbWFV&_nc_zt=23&_nc_ht=scontent.fjai1-2.fna&_nc_gid=AreSFwFpZ13UiD9kssDQpul&oh=00_AYDRtL04EmcJtwPTCevWbh5_nXoAzAA0BYFq7NTIpteVuQ&oe=676DA526',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Header
                  Text(
                    "Join the Toonsutra Universe!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Username Field
                  const InputField(
                    hintText: "Username",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),

                  // Email Field
                  const InputField(
                    hintText: "Email",
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 15),

                  // Password Field
                  const InputField(
                    hintText: "Password",
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 30),

                  // Sign-Up Button
                  PrimaryButton(
                    text: "Sign Up Now!",
                    onPressed: () {
                      // Handle sign-up logic
                    },
                  ),

                  const SizedBox(height: 15),

                  // Sign-In Link
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Already have an account? Log in.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
