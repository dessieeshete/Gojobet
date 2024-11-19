import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedLocation;
  String? _selectedPropertyType;
  RangeValues _priceRange = RangeValues(100000, 1000000);

  final List<String> _locations = ['Los Angeles', 'New York', 'Austin', 'Miami'];
  final List<String> _propertyTypes = ['House', 'Apartment', 'Villa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Properties'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for properties...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Filter by Location Dropdown
            Text(
              'Select Location',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _selectedLocation,
              hint: Text('Select a location'),
              items: _locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLocation = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Filter by Property Type Dropdown
            Text(
              'Property Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _selectedPropertyType,
              hint: Text('Select a property type'),
              items: _propertyTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPropertyType = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Filter by Price Range
            Text(
              'Price Range',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RangeSlider(
              values: _priceRange,
              min: 50000,
              max: 5000000,
              divisions: 100,
              labels: RangeLabels(
                '\$${_priceRange.start.toInt()}',
                '\$${_priceRange.end.toInt()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            SizedBox(height: 20),

            // Search Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement search functionality based on the filters applied
                  _performSearch();
                },
                child: Text('Search'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() {
    String searchQuery = _searchController.text;
    String location = _selectedLocation ?? 'Any';
    String propertyType = _selectedPropertyType ?? 'Any';
    String priceRange = '\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}';

    // Display the search criteria
    print('Search Query: $searchQuery');
    print('Location: $location');
    print('Property Type: $propertyType');
    print('Price Range: $priceRange');

    // In a real app, here you would typically send the filters to a backend or use them to query a database
  }
}
