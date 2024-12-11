import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:library_management/VIew/Top_bar.dart';
import 'package:library_management/model/Books_model.dart'; // Import the Book model
import 'package:library_management/VIew/Details.dart';
import 'package:library_management/Service/books_service.dart'; // Book service
import 'package:get/get.dart'; // GetX for navigation

class DashboardPage extends StatelessWidget {
  final BookService bookService = BookService(); // Instantiate the BookService

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth < 600 ? 16.0 : 24.0;
    double verticalPadding = screenWidth < 600 ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 7, 26), // Dark background
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 32, 1, 42),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 1, 18, 48).withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                                vertical: verticalPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                ],
                              ),
                            ),
                            _buildBookSection(horizontalPadding, 'Top Choice!', 0, 10),
                            SizedBox(height: 20),
                            _buildBookSection(horizontalPadding, 'Populer!', 10, 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookSection(double horizontalPadding, String title, int startIndex, int endIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          FutureBuilder<List<Book>>(
            future: bookService.fetchBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No books found.', style: TextStyle(color: Colors.white)));
              }

              final booksToDisplay = snapshot.data!.getRange(startIndex, endIndex).toList();

              return Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16.0, // Horizontal space between items
                  runSpacing: 16.0, // Vertical space between rows
                  children: booksToDisplay.map((book) {
                    return _buildBookCard(book);
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Book book) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BookPage(), arguments: book);
      },
      child: Container(
        width: 100, // Set a fixed width for consistent alignment
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center align card content
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      book.image ?? 'https://example.com/placeholder.jpg', // Placeholder image
                      width: 100,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              width: 100,
              child: Text(
                book.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 4),
            SizedBox(
              width: 100,
              child: Text(
                book.authors.isNotEmpty ? book.authors[0].name : 'Unknown Author',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
