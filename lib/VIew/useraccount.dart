import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management/controllers/profileController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Website',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Merriweather',
      ),
      home: const UserAccountPage(),
    );
  }
}

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        backgroundColor: Colors.brown[600],
        actions: [
          IconButton(
            onPressed: () {
              // Implement settings navigation
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Section
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.chooseImage();
                    },
                    child: Obx(() {
                      return CircleAvatar(
                        radius: 60, // Increased size
                        backgroundImage: controller.profileImage.value.path.isNotEmpty
                            ? FileImage(controller.profileImage.value)
                            : const AssetImage('assets/user_profile.png')
                                as ImageProvider,
                        child: controller.profileImage.value.path.isEmpty
                            ? const Icon(Icons.camera_alt, size: 60)
                            : null,
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 26, // Increased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.chooseImage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                    ),
                    child: const Text("Edit Profile"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Reading Stats
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat("Books Read", "25"),
                    _buildStat("Current Streak", "7 days"),
                    _buildStat("Wishlist", "12"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Wishlist and Favorites
            const Text(
              "My Favorites",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildBookCard("Book Title 1", "assets/book1.png"),
                  _buildBookCard("Book Title 2", "assets/book2.png"),
                  _buildBookCard("Book Title 3", "assets/book3.png"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recently Read
            const Text(
              "Recently Read",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildBookCard("Book Title 4", "assets/book4.png"),
                  _buildBookCard("Book Title 5", "assets/book5.png"),
                  _buildBookCard("Book Title 6", "assets/book6.png"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildBookCard(String title, String imagePath) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
