import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management/controllers/Search_Controller.dart';

class SearchWidget extends StatelessWidget {
  final SearchbarController controller = Get.put(SearchbarController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onSubmitted: (query) {
            if (query.isNotEmpty) {
              controller.searchBooks(query); // Call searchBooks on submit
            }
          },
          decoration: InputDecoration(hintText: 'Search books...'),
        ),
        Obx(() {
          if (controller.showResults.value) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.searchResults.length,
              itemBuilder: (context, index) {
                final book = controller.searchResults[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.authors.map((a) => a.name).join(', ')),
                  onTap: () {
                    // Handle book selection
                  },
                );
              },
            );
          } else {
            return Container(); // Hide the list if no results
          }
        }),
      ],
    );
  }
}
