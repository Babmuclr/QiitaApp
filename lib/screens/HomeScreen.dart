import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qiita_app/screens/ArticleScreen.dart';

import '../components/Article.dart';

class HomeScreen extends StatefulWidget {
  final String collectionName;
  HomeScreen({Key? key, required this.collectionName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List> fetchArticles(String dataName) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(dataName).get();

    List _articles = snapshot.docs.map((DocumentSnapshot doc) {
      return doc.data();
    }).toList();
    return _articles;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List>(
          future: fetchArticles(widget.collectionName),
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
                          userURL: doc["user_url"],
                          likesCount: doc["likes_count"]));
                }).toList(),
              ));
            }
            return Container(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
