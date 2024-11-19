import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// For handling image bytes
import 'dart:html' as html; // For web image picking

import 'package:image_picker/image_picker.dart'; // For mobile file handling

class AddPropertyPage extends StatefulWidget {
  @override
  _AddPropertyPageState createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  Uint8List? _imageBytes; // For storing image bytes
  bool _isLoading = false; // Field to control loading state

  // Pick image for both web and mobile
  Future<void> _pickImage() async {
    if (kIsWeb) {
      try {
        final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
        uploadInput.accept = 'image/*';
        uploadInput.click();
        uploadInput.onChange.listen((e) async {
          final files = uploadInput.files!;
          final reader = html.FileReader();
          
          reader.readAsArrayBuffer(files[0]);
          reader.onLoadEnd.listen((e) {
            setState(() {
              _imageBytes = reader.result as Uint8List;
            });
          });
        });
      } catch (error) {
        print("Failed to pick image: $error");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to pick image: $error')));
      }
    } else {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final fileBytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = fileBytes;
        });
      }
    }
  }

  // Upload image to Firebase Storage
  Future<String> _uploadImage(Uint8List image) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('property_images/${DateTime.now().toIso8601String()}'); // Adjust path as needed
      UploadTask uploadTask = ref.putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
      return '';
    }
  }

  // Submit form and upload data
  Future<void> _submitForm() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final price = double.tryParse(_priceController.text);

    if (title.isEmpty || description.isEmpty || price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all fields correctly.')));
      return;
    }

    if (_imageBytes != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final imageUrl = await _uploadImage(_imageBytes!);
        await addProperty(
          title: title,
          description: description,
          imageUrl: imageUrl,
          price: price,
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Property added successfully')));
        // Optionally, clear the form or navigate away
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add property: $error')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _imageBytes == null
                ? Text('No image selected.')
                : Image.memory(_imageBytes!, height: 150, fit: BoxFit.cover),
            TextButton(
              onPressed: _pickImage,
              child: Text('Pick an Image'),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
          ],
        ),
      ),
    );
  }
}

Future<void> addProperty({
  required String title,
  required String description,
  required String imageUrl,
  required double price,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('User not authenticated');
  }

  try {
    // Reference to Firestore collection
    CollectionReference properties = FirebaseFirestore.instance.collection('properties');

    // Add a new document with the specified data
    await properties.add({
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'timestamp': FieldValue.serverTimestamp(), // Use server timestamp
      'uid': user.uid, // Store user ID for additional access control if needed
    });

    print("Property added successfully");
  } catch (error) {
    print("Failed to add property: $error");
    throw error;
  }
}
