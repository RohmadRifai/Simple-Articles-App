import 'dart:convert';

import 'package:http/http.dart' as http;

class Article {
  final String title;
  final String content;
  final String image;
  final DateTime date;

  Article(
      {required this.title,
      required this.content,
      required this.image,
      required this.date});

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      title: json['title'],
      content: json['content'],
      image: json['image'],
      date: DateTime.parse(json['created']['date']));

  static Future<List<Article>> fetch() async {
    final response =
        await http.get(Uri.parse('https://demo.treblle.com/api/v1/articles'));
    final json = jsonDecode(response.body);
    final data = json['articles'] as List;
    final articles = data.map((e) => Article.fromJson(e)).toList();

    return articles;
  }
}
