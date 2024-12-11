import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageSecond extends StatefulWidget {
  const PageSecond({super.key});

  @override
  _PageSecondState createState() => _PageSecondState();
}

class _PageSecondState extends State<PageSecond> {
  // List to store quotes fetched from the API
  List<Map<String, String>> quotes = [];
  // List to store favorite quotes
  Set<String> favoriteQuotes = {};

  @override
  void initState() {
    super.initState();
    // Fetch the quotes when the page is initialized
    fetchQuotes();
    // Load favorite quotes from shared preferences
    loadFavorites();
  }

  // Method to fetch quotes using Dio from ZenQuotes API
  Future<void> fetchQuotes() async {
    final dio = Dio();

    try {
      final response = await dio.get('https://library-server-6081p6aba-garvgyanani101-gmailcoms-projects.vercel.app/api/zenquotes');

      // Check if the status code is OK (200)
      if (response.statusCode == 200) {
        // Log the response data for debugging purposes
        print("Response data: ${response.data}");

        // Parse the response and extract the quotes
        List<Map<String, String>> fetchedQuotes = [];
        for (var quote in response.data) {
          fetchedQuotes.add({
            'quote': quote['q'],
            'author': quote['a'],
          });
        }

        // Update the UI with the fetched quotes
        setState(() {
          quotes = fetchedQuotes;
        });
      } else {
        // Handle unsuccessful status codes
        print('Failed to load quotes. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any errors and print them
      print('Error: $e');
    }
  }

  // Load favorites from shared preferences
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteQuotes = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  // Save favorites to shared preferences
  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favoriteQuotes.toList());
  }

  // Toggle favorite status of a quote
  void toggleFavorite(String quote) {
    setState(() {
      if (favoriteQuotes.contains(quote)) {
        favoriteQuotes.remove(quote);
      } else {
        favoriteQuotes.add(quote);
      }
    });
    saveFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 1, 42),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Book quotes',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search, color: Colors.white, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // PageView Section for Quotes
              Expanded(
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    _buildGridView(),
                    _buildGridView(),
                    _buildGridView(),
                  ],
                ),
              ),

              // Footer Section with Navigation
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFooterButton(Icons.home, "Home", isSelected: true),
                  _buildFooterButton(Icons.favorite, "Favorites", onPressed: _showFavorites),
                  _buildFooterButton(Icons.person, "Profile"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds a horizontally scrollable GridView with 2x2 format
  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: quotes.isEmpty
              ? [
                  Center(child: CircularProgressIndicator()) // Loading spinner while waiting for data
                ]
              : List.generate(
                  quotes.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: _buildQuoteCard(
                      quotes[index]['quote']!,
                      quotes[index]['author']!,
                      quotes[index]['quote']!,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // Modern quote card widget with glassmorphism
  Widget _buildQuoteCard(String quote, String author, String uniqueQuote) {
    return Container(
      width: 250,  // Increased width for better readability
      height: 250, // Increased height for better readability
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: Offset(4, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              '"$quote"\n- $author',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.3,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                favoriteQuotes.contains(uniqueQuote)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.pinkAccent,
              ),
              onPressed: () => toggleFavorite(uniqueQuote),
            ),
          ),
        ],
      ),
    );
  }

  // Footer button with icon and text
  Widget _buildFooterButton(IconData icon, String label, {bool isSelected = false, void Function()? onPressed}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: isSelected ? Colors.purpleAccent : Colors.white,
            size: 28,
          ),
          onPressed: onPressed,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.purpleAccent : Colors.white,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Show favorite quotes
  void _showFavorites() {
    // Filter the quotes to show only favorites
    List<Map<String, String>> favoriteQuotesList = quotes
        .where((quote) => favoriteQuotes.contains(quote['quote']))
        .toList();

    setState(() {
      quotes = favoriteQuotesList;
    });
  }
}
