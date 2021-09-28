import 'package:flutter/material.dart';

import 'package:qiita_app/main.dart';
import 'package:qiita_app/screens/ArticleScreen.dart';

import '../components/Article.dart';

class HomeScreen extends StatefulWidget {
  final int collectionIndex;
  HomeScreen({Key? key, required this.collectionIndex}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() async {
    setState(() {
      getArticles(nameList);
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: articleList[widget.collectionIndex].length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleScreen(
                        url: articleList[widget.collectionIndex][index]["url"]),
                  ),
                );
              },
              child: Article(
                  title: articleList[widget.collectionIndex][index]["title"],
                  tags: articleList[widget.collectionIndex][index]["tags"],
                  author: articleList[widget.collectionIndex][index]["author"],
                  id: articleList[widget.collectionIndex][index]["id"],
                  url: articleList[widget.collectionIndex][index]["url"],
                  likesCount: articleList[widget.collectionIndex][index]
                      ["likes_count"]));
        },
      ),
    ));
  }
}
