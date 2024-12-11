import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImage = File('').obs;
  late Database _database;

  @override
  void onInit() {
    super.onInit();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = join(directory.path, 'user_profile.db');
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE Profile(id INTEGER PRIMARY KEY, imagePath TEXT)');
      },
    );
    await _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final result = await _database.query('Profile', limit: 1);
    if (result.isNotEmpty) {
      profileImage.value = File(result.first['imagePath'] as String);
    }
  }

  Future<void> _saveProfileImage(File image) async {
    await _database.delete('Profile'); // Clear previous data
    await _database.insert('Profile', {'imagePath': image.path});
    profileImage.value = image;
  }

  Future<void> chooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      await _saveProfileImage(file);
    }
  }
}
