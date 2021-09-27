import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'screens/HomeScreen.dart';
import 'screens/FavoriteScreen.dart';

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
      home: QiitaApp(),
    );
  }
}

class QiitaApp extends StatefulWidget {
  const QiitaApp({Key? key}) : super(key: key);

  @override
  _QiitaAppState createState() => _QiitaAppState();
}

class _QiitaAppState extends State<QiitaApp> {
  int _currentIndex = 0;
  final _pageWidgets = [
    HomeScreen(
      collectionName: "articles_new",
    ),
    HomeScreen(
      collectionName: "articles_pop",
    ),
    HomeScreen(
      collectionName: "articles_most",
    ),
    FavoriteScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qiita News"),
      ),
      body: _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_album), label: 'Album'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.white,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index);
}
