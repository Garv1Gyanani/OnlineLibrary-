import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management/VIew/Details.dart';
import 'package:library_management/VIew/useraccount.dart';
import 'package:library_management/controllers/Search_Controller.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final TextEditingController searchController = TextEditingController();
  final SearchbarController searchControllerInstance = Get.put(SearchbarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(34, 0, 0, 0),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Dashboard",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, color: Colors.grey),
                onPressed: _openSearchModal,
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.grey),
                onPressed: () {
                  Get.to(()=>UserAccountPage());
                }, // Add notification functionality here
              ),
              CircleAvatar(
                backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/130121347?v=4'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: (value) {
                  _performSearch(value);
                },
              ),
              const SizedBox(height: 16),
              Obx(() {
                if (searchControllerInstance.showResults.value) {
                  return _buildSearchResults();
                } else if (searchController.text.isEmpty) {
                  return Center(child: Text("Start typing to search...", style: TextStyle(color: Colors.grey)));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
            ],
          ),
        );
      },
    );
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      searchControllerInstance.searchBooks(query);
    }
  }

  Widget _buildSearchResults() {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 300, // Adjust this height as needed
        child: ListView.separated(
          itemCount: searchControllerInstance.searchResults.length,
          separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300),
          itemBuilder: (context, index) {
            final book = searchControllerInstance.searchResults[index];
            return ListTile(
              leading: Image.network(
                book.image ?? '',
                width: 40,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(book.title, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                book.authors.map((a) => a.name).join(', '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => Get.to(() => const BookPage(), arguments: book),
            );
          },
        ),
      ),
    );
  }
}
