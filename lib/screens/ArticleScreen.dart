import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  final String url;
  const ArticleScreen({Key? key, required this.url}) : super(key: key);
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Qiita App"),
        ),
        body: WebView(
          initialUrl: widget.url,
          // javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
