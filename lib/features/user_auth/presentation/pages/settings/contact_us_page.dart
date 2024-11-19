import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('We would love to hear from you!', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('Email: contact@realestateapp.com', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Phone: +123 456 7890', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Address: 123 Real Estate Street, City, Country', style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle contact form submission or action here
              },
              child: Text('Send Us a Message'),
            ),
          ],
        ),
      ),
    );
  }
}
