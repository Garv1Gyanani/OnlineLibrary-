import 'package:dio/dio.dart';
import '../model/Books_model.dart';

class BookService {
  final Dio _dio = Dio();

  Future<List<Book>> fetchBooks() async {
    try {
      final response = await _dio.get('https://library-server-owqsjfq01-garvgyanani101-gmailcoms-projects.vercel.app/api/books?page=3');
      if (response.statusCode == 200) {
        // Check if 'results' key exists and is a List
        if (response.data['results'] is List) {
          List<Book> books = (response.data['results'] as List)
              .map((bookJson) => Book.fromJson(bookJson))
              .toList();
          return books;
        } else {
          throw Exception('Unexpected response format: results is not a list');
        }
      } else {
        throw Exception('Failed to load books. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching books: $e');
      throw Exception('Error fetching books: $e');
    }
  }
  Future<List<Map<String, dynamic>>> bookshelves() async {  

     final List<Map<String,dynamic>> Allshelves=[];
     final List<Book> fetchedBooks = await fetchBooks();
     for(var book in fetchedBooks){
          if(book.bookshelves.isNotEmpty){
            Allshelves.addAll(book.bookshelves.map((shelve)=>{'shelve':shelve}));
          }
     }
     print(Allshelves);
     return Allshelves;

}


}void main ()async{
  BookService abc = BookService();
  abc.bookshelves();
}