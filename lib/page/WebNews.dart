import 'package:agah/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebNews extends StatelessWidget {
  final String url;
  final String title;

  // In the constructor, require a Todo.
  WebNews({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.getPrimaryBackAppbar(context, title),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
