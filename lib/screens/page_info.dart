import 'package:flutter/material.dart';
import '../components/news_component.dart';
import 'package:provider/provider.dart';
import '../provider/news_provider.dart';

class PageInfo extends StatelessWidget {
  const PageInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: 
    Container(
        alignment: Alignment.center,
        child: const NewsPage(),
      ));
  }
}