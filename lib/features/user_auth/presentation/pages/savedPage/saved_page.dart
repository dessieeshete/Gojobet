import 'package:flutter/material.dart';

class SavedPage extends StatelessWidget {
  final List<String> savedItems;

  const SavedPage({super.key, required this.savedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Items'),
      ),
      body: savedItems.isNotEmpty
          ? ListView.builder(
              itemCount: savedItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(savedItems[index]),
                  leading: Icon(Icons.bookmark),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Handle item deletion here
                      // For example, call a function to remove the item from the savedItems list
                    },
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No saved items',
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}
