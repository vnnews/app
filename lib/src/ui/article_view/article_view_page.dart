import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:vnnews/src/model/article_model.dart';

class ArticleViewPage extends StatelessWidget {
  final ArticleModel article;

  const ArticleViewPage({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.metadata.ogTitle ?? ''),
      ),
      body: ListView(
        children: [
          ListTile(title: Text(article.metadata.ogTitle ?? '')),
          ListTile(
            title: Text('timestamp'),
            subtitle:
                Text(article.timestamp?.toDate()?.toIso8601String() ?? ''),
          ),
          ListTile(
            title: Text('first_timestamp'),
            subtitle:
                Text(article.firstTimestamp?.toDate()?.toIso8601String() ?? ''),
          ),
          if (article.hasHistory == true)
            ListTile(
              title: Text('has_history'),
              subtitle: Text('true'),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              article.body,
              webView: true,
            ),
          ),
        ],
      ),
    );
  }
}
