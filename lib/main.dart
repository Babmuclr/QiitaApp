import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ArticleScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: ArticleScreen(),
      home: MyHomePage(title: 'Qiita App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List>(
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
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
