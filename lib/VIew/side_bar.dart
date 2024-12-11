import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management/VIew/allbooks.dart';

// Sidebar Item Widget
class SidebarItem extends StatelessWidget {
  final IconData icon;

  SidebarItem({required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Remove default padding
      contentPadding: EdgeInsets.zero, 
      title: Center(
        child: Icon(icon, color: Colors.white),
      ),
      onTap: () {
        Get.to(()=>DashboardPage2());
        // Add navigation logic here if needed
        print('Sidebar item tapped: $icon');
      },
    );
  }
}

// Sidebar Widget
class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: const Color.fromARGB(34, 0, 0, 0),
      
      child: Padding(
        padding: const EdgeInsets.only(top:20.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                'GO',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 20,),
            // Use ListView for better performance if items can scroll
            Expanded(
              child: ListView(
                children: [
                  SidebarItem(icon: Icons.dashboard),
                  SidebarItem(icon: Icons.book),
                  SidebarItem(icon: Icons.help),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Sidebar Example')),
      body: Row(
        children: [
          Sidebar(), // The sidebar widget
          Expanded(
            child: Center(child: Text('Main Content')),
          ),
        ],
      ),
    ),
  ));
}
