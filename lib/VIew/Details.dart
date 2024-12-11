import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_management/model/Books_model.dart';
import 'dart:html' as html;

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Book book = Get.arguments;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20), // Dark background for the scaffold
      appBar: AppBar(
        title: Text(
          book.title,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 7, 26), // Dark background for the app bar
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 28),
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(book.image ?? ''),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 1, 7, 26), // Darker background for the content area
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book Image
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            book.image ?? '',
                            width: 200,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Book Details in a Card
                      Card(
                        color: const Color.fromARGB(255, 32, 1, 42),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                book.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                book.authors.isNotEmpty ? book.authors[0].name : 'Unknown Author',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              // Rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 24),
                                  const Icon(Icons.star, color: Colors.amber, size: 24),
                                  const Icon(Icons.star, color: Colors.amber, size: 24),
                                  const Icon(Icons.star, color: Colors.amber, size: 24),
                                  const Icon(Icons.star_border, color: Colors.amber, size: 24),
                                  const SizedBox(width: 8),
                                  Text(
                                    "4.4",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "(520 reviews)",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "\₹50", // Display book price
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Details Section with Tabs
                      DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            TabBar(
                              tabs: [
                                Tab(text: "Details"),
                                Tab(text: "Reviews"),
                              ],
                              labelColor: Colors.teal,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.teal,
                            ),
                            Container(
                              height: 300, // Height of tab content
                              child: TabBarView(
                                children: [
                                  // Details Tab
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            'Downloads: ${book.downloadCount}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            book.bookshelves.isNotEmpty ? book.bookshelves[0] : 'Unknown Shelf',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            "              ISBN-10: 0143453580\n"
                                            "              ISBN-13: 978-0143453581\n"
                                            "              Edition: First Edition\n"
                                            "              Publisher: Penguin Random House\n",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Reviews Tab
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "User reviews will be displayed here. Users can leave their comments and ratings about the book.",
                                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Action Buttons Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            onPressed: () {
                              html.window.open(book.epubLink!, '_blank');
                            },
                            icon: const Icon(Icons.shopping_cart, color: Colors.white),
                            label: Text(
                              "Download",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            onPressed: () {
                              html.window.open(book.htmlLink!, '_blank');
                            },
                            icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                            label: Text(
                              "Read Now",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
