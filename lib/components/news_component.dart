import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/news_provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewsProvider>(context, listen: false).getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, value, child) {
        // If the loading it true then it will show the circular progressbar
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // If loading is false then this code will show the list of todo item
        final news = value.news;
        // var image = NetworkImage('https://api.lorem.space/image/finance?w=100&h=100');
        return ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            final article = news[index];
            var image = NetworkImage('https://icon.horse/icon/${article.domain}');
            var date = DateTime.parse(article.created_at);
            return GestureDetector(
              child: ListTile(
                minVerticalPadding:11.0,
                leading: CircleAvatar(
                  backgroundImage: image,
                  radius: 23,
                  // child: Image.network('https://random.imagecdn.app/100/100'),
                ),
                title: 
                Column(children: [
                Text(
                  article.title,
                  style: const TextStyle(
                    color:  Color.fromARGB(255, 80, 80, 80),
                    fontSize: 13,
                  ),
                ),
                Flex(
                direction:Axis.horizontal,
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  // Text('#${todo.kind.toString()}'),
                  Text('#${article.sourceTitle.toString()}',
                  style: const TextStyle(color: Color.fromARGB(255, 11, 50, 77),fontSize: 10),),
                  Text('${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}',
                  style: const TextStyle(color: Color.fromARGB(255, 11, 50, 77),fontSize: 8),
                  ),
                  

                ],)
                ],)

              ),
            );
          },
        );
      },
    );
  }
}
