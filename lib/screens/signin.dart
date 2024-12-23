import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/background_container.dart';
import 'package:quiz_app/screens/signup.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          const BackgroundContainer(),

          // Sign-In Form
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
                    "Welcome Back!",
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
                  const SizedBox(height: 10),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Forgot Password Screen
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sign-In Button
                  PrimaryButton(
                    text: "Sign In",
                    onPressed: () {
                      // Handle sign-in logic
                    },
                  ),

                  const SizedBox(height: 15),

                  // Sign-Up Link
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Don’t have an account? Sign up.",
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
