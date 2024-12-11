import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;  // Use alias for path package

class EditProfileDemo extends StatefulWidget {
  @override
  _EditProfileDemoState createState() => _EditProfileDemoState();
}

class _EditProfileDemoState extends State<EditProfileDemo> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = p.join(directory.path, 'user_profile.db');  // Use p.join instead
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE Profile(id INTEGER PRIMARY KEY, imagePath TEXT)');
      },
    );
    await _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    if (_database != null) {
      final result = await _database!.query('Profile', limit: 1);
      if (result.isNotEmpty) {
        final imagePath = result.first['imagePath'] as String;
        setState(() {
          _profileImage = File(imagePath);
        });
      }
    }
  }

  Future<void> _saveProfileImage(File image) async {
    if (_database != null) {
      final imagePath = image.path;
      await _database!.delete('Profile'); // Clear previous data
      await _database!.insert('Profile', {'imagePath': imagePath});
    }
  }

  Future<void> _chooseImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery); // Gallery option
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      await _saveProfileImage(file); // Save to SQLite
      setState(() {
        _profileImage = file;
      });
    }
  }

  void _showEditProfilePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {  // Use dialogContext here
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _chooseImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(Icons.camera_alt, size: 50)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Use dialogContext here
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Save other user details to MongoDB
                Navigator.of(dialogContext).pop(); // Use dialogContext here
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _showEditProfilePopup(context); // Pass the context
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? const Icon(Icons.camera_alt, size: 60)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showEditProfilePopup(context); // Pass the context
              },
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
