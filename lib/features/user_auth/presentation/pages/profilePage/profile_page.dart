import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/features/user_auth/presentation/pages/home_page.dart';
import 'package:firstapp/features/user_auth/presentation/pages/login_page.dart';
import 'package:firstapp/features/user_auth/presentation/pages/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to login page after logout
                );
              } catch (e) {
                print("Error signing out: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to sign out: $e')),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display user profile image or placeholder if not available
              CircleAvatar(
                radius: 50,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : AssetImage('images/house3.jpg') as ImageProvider,
              ),
              SizedBox(height: 16),
              // Display user details
              Text(
                'Welcome, ${user?.displayName ?? 'User'}!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                user?.email ?? 'user@example.com',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 32),
              // Edit Profile button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()), // Navigate to EditProfilePage
                  );
                },
                child: Text('Edit Profile'),
              ),
              SizedBox(height: 16),
              // Navigate to home page
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()), // Navigate to home page
                  );
                },
                child: Text('Go to Home Page'),
              ),
              SizedBox(height: 16),
              // Logout button
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to login page after logout
                    );
                  } catch (e) {
                    print("Error signing out: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to sign out: $e')),
                    );
                  }
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

