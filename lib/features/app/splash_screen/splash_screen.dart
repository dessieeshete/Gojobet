import 'package:firstapp/features/user_auth/presentation/pages/login_page.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add any initialization logic or delay here
    _navigateToLoginPage();
  }

  void _navigateToLoginPage() {
    Future.delayed(const Duration (seconds: 3), () {
      // Navigate to the home page after the splash screen is displayed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 98, 98),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                    'WelCome TO',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Your HOME',
                    style: TextStyle(
                      fontSize: 44.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Arial',
                      color: Color.fromARGB(255, 19, 110, 156),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}