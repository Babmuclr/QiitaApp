import 'package:flutter/material.dart';
import 'package:qiita_app/screens/ArticleScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../components/Article.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List> fetchArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _favoriteList = prefs.getStringList("favorite") ?? [];

    List _articles = [];
    _favoriteList.forEach((id) {
      dynamic _jsonData = jsonDecode(prefs.getString(id) ?? "");
      _jsonData["id"] = id;
      _articles.add(_jsonData);
    });
    return _articles;
  }

  Future<void> _onRefresh() async {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: FutureBuilder<List>(
            future: fetchArticles(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return SingleChildScrollView(
                    child: Column(
                  children: data!.map((doc) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArticleScreen(url: doc["url"]),
                            ),
                          );
                        },
                        child: Article(
                            title: doc["title"],
                            tags: doc["tags"],
                            author: doc["author"],
                            id: doc["id"],
                            url: doc["url"],
                            likesCount: doc["likes_count"],
                            isFavorite: true));
                  }).toList(),
                ));
              }
              return Container(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
