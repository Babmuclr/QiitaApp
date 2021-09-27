import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'screens/ArticleScreen.dart';
import 'screens/HomeScreen.dart';

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
      home: QiitaApp(title: "Qiita App"),
    );
  }
}

class QiitaApp extends StatefulWidget {
  const QiitaApp({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _QiitaAppState createState() => _QiitaAppState();
}

class _QiitaAppState extends State<QiitaApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ArticleScreen(),
    ));
  }
}
