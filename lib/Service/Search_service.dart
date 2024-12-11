import 'package:library_management/model/Books_model.dart';
import 'package:dio/dio.dart';
class SearchService {
  final Dio _dio = Dio();

  // Method to search for books based on a query
  Future<List<Book>> searchBooks(String query) async {
    try {
      String encodedQuery = Uri.encodeQueryComponent(query);
      final response = await _dio.get('https://library-server-owqsjfq01-garvgyanani101-gmailcoms-projects.vercel.app/api/books?search=$encodedQuery');

      // Log the response for debugging
      print('Response data: ${response.data}'); // Log the full response data

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['results'] is List) {
          List<Book> books = (response.data['results'] as List)
              .map((bookJson) => Book.fromJson(bookJson))
              .toList();
          return books;
        } else {
          throw Exception('Unexpected response format: "results" is not a list or is missing');
        }
      } else {
        throw Exception('Failed to search books. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while searching for books: $e');
      throw Exception('Error occurred while searching for books: $e');
    }
  }
}
