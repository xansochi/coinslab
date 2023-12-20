import 'package:flutter/material.dart';
import '../api/news_api.dart';

class NewsProvider extends ChangeNotifier {
  final _service = NewsService();
  bool isLoading = false;
  List<dynamic> _news = [];
  List<dynamic> get news => _news;

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAll();
    _news = response;
    isLoading = false;
    notifyListeners();
  }
}