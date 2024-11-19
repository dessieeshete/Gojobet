import 'package:firstapp/features/user_auth/presentation/pages/property/property_detail_page.dart';
import 'package:flutter/material.dart';
 // Assuming you have the Property model.

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Properties'),
        backgroundColor: Colors.blueGrey,
      ),
      body: favoriteProperties.isEmpty
          ? Center(
              child: Text(
                'No favorite properties yet!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favoriteProperties.length,
              itemBuilder: (context, index) {
                final property = favoriteProperties[index];
                
                return Dismissible(
                  key: Key(property.title),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    // Remove from the favorites list
                    favoriteProperties.removeAt(index);

                    // Show a snackbar or any confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${property.title} removed from favorites')),
                    );
                  },
                  child: ListTile(
                    leading: Image.asset(
                      property.imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(property.title),
                    subtitle: Text(property.price),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyDetailPage(property: property),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
