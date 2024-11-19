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
// Ensure to import the SignUpPage if needed

// Ensure this import is correct

class AuthGuard extends StatelessWidget {
  final Widget child;

  AuthGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Check if user is signed in
    if (user == null) {
      // Redirect to login page if not signed in
      return LoginPage(); // Change this to Navigator logic if you prefer
    } else {
      // Display the child widget if user is signed in
      return child;
    }
  }
}
