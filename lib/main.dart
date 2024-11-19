import 'package:firstapp/features/user_auth/presentation/pages/favorites_page/favorites_page.dart';
import 'package:firstapp/features/user_auth/presentation/pages/settings/contact_us_page.dart';
import 'package:firstapp/features/user_auth/presentation/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/features/user_auth/presentation/pages/home_page.dart';
import 'package:firstapp/features/user_auth/presentation/pages/login_page.dart';
import 'package:firstapp/features/user_auth/presentation/pages/signup_page.dart';
import 'package:firstapp/features/user_auth/presentation/pages/SearchPage/search_page.dart';
import 'package:firstapp/features/user_auth/presentation/pages/profilePage/profile_page.dart';
import 'package:firstapp/features/user_auth/presentation/widgets/add_property_page.dart';
import 'dart:collection';
import 'dart:typed_data';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UnmodifiableListView<int>(Int32List(0));
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBsyYXwxXYj4uTWA0GJnocUxDjS5J_VRX0",
    projectId: "houserent-4ac49",
    messagingSenderId: "693038262788",
    storageBucket: "gs://houserent-4ac49.appspot.com",
    appId: "1:693038262788:android:e2a4bebc8734e4ca11e351",
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ጎጆ ቤቴ',
      home: MainScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Define the initial route
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => MainScreen(),
        '/signup': (context) => SignUpPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => LoginPage());
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    AddPropertyPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // Close the drawer after an item is selected
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real Estate App'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => _onDrawerItemSelected(0),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () => _onDrawerItemSelected(1),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Property'),
              onTap: () => _onDrawerItemSelected(2),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () => _onDrawerItemSelected(3),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () => _onDrawerItemSelected(4),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 155, 116, 116),
        color: Colors.blue,
        buttonBackgroundColor: const Color.fromARGB(255, 45, 142, 105),
        height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
      ),
    );
  }
}
