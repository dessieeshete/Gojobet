import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'property/animated_category_chips.dart';
import 'property/nearby_property_card.dart';
import 'property/property.dart';
import 'property/property_card.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Property> featuredProperties = properties; // Use sample properties

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Your Dream Home'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image / Carousel
            Container(
              height: 250,
              child: CarouselSlider.builder(
                itemCount: featuredProperties.length,
                itemBuilder: (context, index, realIdx) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        featuredProperties[index].imagePath,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.4),
                        child: Center(
                          child: Text(
                            'Find Your Dream Home',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  viewportFraction: 1.0,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Search Bar with Suggestions
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for properties, neighborhoods, etc...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Animated Category Chips
            AnimatedCategoryChips(),

            // Featured Properties Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Text(
                'Featured Properties',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider.builder(
              itemCount: featuredProperties.length,
              itemBuilder: (context, index, realIdx) {
                return PropertyCard(property: featuredProperties[index]);
              },
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 0.8,
              ),
            ),
            SizedBox(height: 10),

            // Nearby Properties Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Properties Near You',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredProperties.length,
                itemBuilder: (context, index) {
                  return NearbyPropertyCard(property: featuredProperties[index]);
                },
              ),
            ),
            SizedBox(height: 10),

            // Find Properties Near Me Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Implement location-based feature here
                },
                icon: Icon(Icons.location_on),
                label: Text('Find Properties Near Me'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Recent Activity
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Recent Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3, // Number of recently viewed properties
              itemBuilder: (context, index) {
                return PropertyCard(property: featuredProperties[index]);
              },
            ),
            SizedBox(height: 20),

            // Contact Us Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement contact us logic
                    },
                    child: Text(
                      'Get in Touch',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
