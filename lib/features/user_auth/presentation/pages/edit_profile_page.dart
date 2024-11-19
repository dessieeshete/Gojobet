// TODO Implement this library.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  File? _profileImage;
  bool _isLoading = false;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _displayNameController.text = user?.displayName ?? '';
    _emailController.text = user?.email ?? '';
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String? imageUrl;

      if (_profileImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${user?.uid}.jpg');

        await storageRef.putFile(_profileImage!);
        imageUrl = await storageRef.getDownloadURL();
      }

      await user?.updateDisplayName(_displayNameController.text);
      await user?.updateEmail(_emailController.text);
      if (imageUrl != null) {
        await user?.updatePhotoURL(imageUrl);
      }

      await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
        'displayName': _displayNameController.text,
        'email': _emailController.text,
        'photoURL': imageUrl ?? user?.photoURL,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      print("Error updating profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : user?.photoURL != null
                              ? NetworkImage(user!.photoURL!)
                              : AssetImage('images/placeholder.png') as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _displayNameController,
                    decoration: InputDecoration(labelText: 'Display Name'),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    child: Text('Update Profile'),
                  ),
                ],
              ),
      ),
    );
  }
}
