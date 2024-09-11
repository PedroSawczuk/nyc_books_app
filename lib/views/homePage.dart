import 'package:flutter/material.dart';
import 'package:nyc_books_app/models/booksModel.dart';
import 'package:nyc_books_app/services/bookServices.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookServices _bookServices = BookServices();

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text('Books App API'),
      ),
      body: FutureBuilder(
          future: _bookServices.fetchBooksInformation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao acessar API!'),
              );
            } else if (snapshot.hasData) {
              final books = snapshot.data as List<BooksModel>;
              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return ListTile(
                    leading: Image.network(
                      book.bookImage,
                      height: 50,
                    ),
                    title: Text(book.title),
                    subtitle: Text('Autor: ${book.author}'),
                    
                  );
                },
              );
            } else {
              return Center(child: Text('Nenhum dado disponível'));
            }
          }),
    );
  }
}
