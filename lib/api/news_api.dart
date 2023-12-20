// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants_api.dart';

class News {
  final String kind;
  final String domain;
  final String title;
  final String created_at;
  final String sourceTitle;
  News({
    required this.kind,
    required this.title,
    required this.domain,
    required this.created_at,
    required this.sourceTitle,
  });
}

class NewsService {
  Future<List<dynamic>> getAll() async {
    const url = ConstantsForApi.newsApiURL;
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
          print(json['results']);
      final news = json['results'].map((e) {
        return News(
          kind: e['kind'],
          title: e['title'],
          domain: e['domain'],
          created_at: e['created_at'],
          sourceTitle:e["source"]["title"],
        );
      }).toList();
      return news;
    }
    return [];
  }
}