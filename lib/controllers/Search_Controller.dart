import 'package:get/get.dart';
import 'package:library_management/Service/Search_service.dart';
import 'package:library_management/model/Books_model.dart';

class SearchbarController extends GetxController {
  var searchResults = <Book>[].obs; // Observable list to hold search results
  var showResults = false.obs; // Observable to track whether to show results
  final SearchService _searchService = SearchService();

  // Method to perform search
  Future<void> searchBooks(String query) async {
    if (query.isNotEmpty) {
      try {
        var results = await _searchService.searchBooks(query);
        searchResults.assignAll(results); // Update the observable list
        showResults.value = true; // Show the results
      } catch (e) {
        print('Error while searching for books: $e');
        showResults.value = false; // Hide results on error
      }
    } else {
      searchResults.clear(); // Clear results if the query is empty
      showResults.value = false; // Hide results
    }
  }
}
