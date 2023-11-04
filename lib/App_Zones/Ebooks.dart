import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(Anime());
}

class Ebook {
  final String title;
  final String author;
  final String coverImageUrl;

  Ebook({
    required this.title,
    required this.author,
    required this.coverImageUrl,
  });
}

class EbookService {
  final String apiUrl = "https://api.itbook.store/1.0/books/9781617294136";

  Future<List<Ebook>> fetchEbooks() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final ebooks = data['books'].map<Ebook>((ebook) {
        return Ebook(
          title: ebook['title'],
          author: ebook['authors'],
          coverImageUrl: ebook['image'],
        );
      }).toList();
      return ebooks;
    } else {
      throw Exception('Failed to load ebooks');
    }
  }
}

class EbookGridView extends StatelessWidget {
  final List<Ebook> ebooks;

  EbookGridView(this.ebooks);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: ebooks.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: Image.network(
            ebooks[index].coverImageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black.withOpacity(0.7),
            title: Text(ebooks[index].title),
            subtitle: Text(ebooks[index].author),
          ),
        );
      },
    );
  }
}

class Anime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Awesome Books'),
        ),
        body: FutureBuilder<List<Ebook>>(
          future: EbookService().fetchEbooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color:Colors.purple));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return EbookGridView(snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}
