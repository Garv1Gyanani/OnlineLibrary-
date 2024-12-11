// lib/book_controller.dart

import 'package:get/get.dart';
import 'package:library_management/model/Books_model.dart';
import 'package:library_management/Service/books_service.dart';

class BookController extends GetxController {
  var books = <Book>[].obs;
  var isLoading = true.obs;

  final BookService bookService = BookService();

  @override
  void onInit() {
    fetchBooks();
    super.onInit();
  }

  void fetchBooks() async {
    try {
      isLoading(true);
      var fetchedBooks = await bookService.fetchBooks();
      books.assignAll(fetchedBooks);
    } finally {
      isLoading(false);
    }
  }
}
