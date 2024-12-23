import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String title;

  const TitleBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child: Row(
          children: [
            // Logo
            ClipOval(
              child: Image.network(
                'https://scontent.fjai1-2.fna.fbcdn.net/v/t39.30808-6/302530852_460829472765777_7355018370173241938_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=Fw_za3hzhggQ7kNvgFHbWFV&_nc_zt=23&_nc_ht=scontent.fjai1-2.fna&_nc_gid=AreSFwFpZ13UiD9kssDQpul&oh=00_AYDRtL04EmcJtwPTCevWbh5_nXoAzAA0BYFq7NTIpteVuQ&oe=676DA526', // Replace with actual URL or asset
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
