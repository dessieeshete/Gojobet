// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firstapp/features/user_auth/presentation/pages/login_page.dart';
// import 'package:firstapp/features/user_auth/presentation/pages/profilePage/profile_page.dart';
// import 'package:firstapp/features/user_auth/presentation/pages/signup_page.dart';
// import 'package:flutter/material.dart';
// class AuthWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           if (snapshot.hasData) {
//             final user = snapshot.data!;
//             return FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
//               builder: (context, userSnapshot) {
//                 if (userSnapshot.connectionState == ConnectionState.done) {
//                   if (userSnapshot.hasData && userSnapshot.data?.exists == true) {
//                     final userData = userSnapshot.data!.data() as Map<String, dynamic>;
//                     bool isNewUser = userData['isNewUser'] ?? true;
//                     if (isNewUser) {
//                       return SignUpPage(); // Redirect to Sign Up page if user is new
//                     } else {
//                       return ProfilePage(); // Redirect to Profile page if user is not new
//                     }
//                   } else {
//                     return SignUpPage(); // If user metadata is not found, treat as new user
//                   }
//                 }
//                 return Center(child: CircularProgressIndicator()); // While fetching user data
//               },
//             );
//           } else {
//             // User is not logged in
//             return LoginPage();
//           }
//         }
//         // While checking authentication status
//         return Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/features/user_auth/presentation/pages/login_page.dart';
import 'package:firstapp/features/user_auth/presentation/pages/profilePage/profile_page.dart';
// Ensure to import the SignUpPage if needed

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show a loading spinner while checking authentication status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text("Loading")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Navigate based on authentication state
        if (snapshot.hasData) {
          // User is logged in, show profile page
          return ProfilePage();
        } else {
          // User is not logged in, show login page
          return LoginPage();
        }
      },
    );
  }
}
