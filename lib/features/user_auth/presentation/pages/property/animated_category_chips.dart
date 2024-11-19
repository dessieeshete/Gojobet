import 'package:flutter/material.dart';

class AnimatedCategoryChips extends StatefulWidget {
  @override
  _AnimatedCategoryChipsState createState() => _AnimatedCategoryChipsState();
}

class _AnimatedCategoryChipsState extends State<AnimatedCategoryChips> {
  int _selectedCategoryIndex = 0;
  final List<String> categories = ['Rent', 'Sale', 'Apartment', 'House'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(categories.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _selectedCategoryIndex == index
                    ? Colors.blueGrey
                    : Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
