import 'package:dio/dio.dart';
import 'package:nyc_books_app/models/booksModel.dart';

class BookServices {
  final Dio _dio = Dio();

  static const apiKey = 'iI3UhRGWqQBl7LmuZsUVTZAMNzfzkdTa';
  static const apiUrl = 'https://api.nytimes.com/svc/books/v3/';

  Future<List<BooksModel>> fetchBooksInformation() async {
    const String allBooksUrl =
        '$apiUrl/lists/full-overview.json?api-key=$apiKey';

    try {
      final response = await _dio.get(allBooksUrl);
      if (response.statusCode == 200) {
        List<dynamic> booksList = [];

        var lists = response.data['results']['lists'] as List;
        for (var list in lists) {
          var books = list['books'] as List;
          booksList.addAll(books);
        }
        return booksList.map((book) => BooksModel.fromJson(book)).toList();
      } else {
        throw Exception('Erro ao tentar pegar informações do livro!');
      }
    } catch (e) {
      throw Exception('Erro ao acessar api ${e}!');
    }
  }
}
