import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchArticles('articles_news');
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
    return FutureBuilder<List>(
        future: fetchArticles("articles_new"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return SingleChildScrollView(
                child: Column(
              children: data!.map((doc) {
                return Card(
                    child: Column(
                  children: [
                    Text(doc["title"]),
                    Text(doc["tags"]),
                    Text(doc["id"]),
                    Text(doc["url"]),
                    Text(doc["likes_count"].toString())
                  ],
                ));
              }).toList(),
            ));
            // ListView.builder(
            //     itemBuilder: (BuildContext context, int index) {
            //   return Container(
            //     height: 80,
            //     child: Text(data![index]["title"]),
            //   );
            // });
          }
          return Container(
            child: Text("a"),
          );
        });
  }
}
