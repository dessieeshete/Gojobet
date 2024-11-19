import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'property.dart'; // Assuming your Property model is defined here.

List<Property> favoriteProperties = []; // Global list to hold favorite properties.

class PropertyDetailPage extends StatefulWidget {
  final Property property;

  PropertyDetailPage({required this.property});

  @override
  _PropertyDetailPageState createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  bool isFavorite = false; // Track whether this property is favorited.

  // Toggle favorite status
  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      favoriteProperties.add(widget.property); // Add to favorites.
    } else {
      favoriteProperties.remove(widget.property); // Remove from favorites.
    }
  }

  // Launch Email
  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.property.contactEmail,
      query: Uri.encodeComponent('subject=Inquiry about ${widget.property.title}'),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      print('Could not launch email client');
    }
  }

  // Launch Phone Call
  Future<void> _launchPhone() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: widget.property.ownerContact,
    );
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      print('Could not launch phone');
    }
  }

  // Launch WhatsApp
  Future<void> _launchWhatsApp() async {
    final Uri whatsappLaunchUri = Uri(
      scheme: 'https',
      path: 'wa.me/${widget.property.ownerContact}',
      query: 'text=Hello, I am interested in your property: ${widget.property.title}',
    );
    if (await canLaunchUrl(whatsappLaunchUri)) {
      await launchUrl(whatsappLaunchUri);
    } else {
      print('Could not launch WhatsApp');
    }
  }

  // Launch Telegram
  Future<void> _launchTelegram() async {
    final Uri telegramLaunchUri = Uri(
      scheme: 'https',
      path: 't.me/${widget.property.telegramUsername}',
    );
    if (await canLaunchUrl(telegramLaunchUri)) {
      await launchUrl(telegramLaunchUri);
    } else {
      print('Could not launch Telegram');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Details'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite, // Add or remove from favorites.
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.property.imagePath,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.property.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.property.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.property.price,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bed, color: Colors.blueGrey),
                          SizedBox(width: 5),
                          Text('${widget.property.bedrooms} Beds'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.bathtub, color: Colors.blueGrey),
                          SizedBox(width: 5),
                          Text('${widget.property.bathrooms} Baths'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.square_foot, color: Colors.blueGrey),
                          SizedBox(width: 5),
                          Text('${widget.property.area} sqft'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Location: ${widget.property.location}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.blueGrey),
                    title: Text('Email '),
                    onTap: _launchEmail,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.mobile_friendly, color: Colors.blueGrey),
                    title: Text('Call '),
                    onTap: _launchPhone,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.call, color: Colors.green),
                    title: Text('WhatsApp '),
                    onTap: _launchWhatsApp,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.telegram, color: Colors.blue),
                    title: Text('Telegram '),
                    onTap: _launchTelegram,
                  ),
                  Divider(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
