class BooksModel {
  final String title;
  final String author;
  final String bookImage;

  BooksModel({
    required this.title,
    required this.author,
    required this.bookImage,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      bookImage: json['book_image'] ?? '', 
    );
  }
}
