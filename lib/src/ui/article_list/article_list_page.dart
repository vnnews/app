import 'package:flutter/material.dart';

import 'article_count_widget.dart';
import 'article_list_widget.dart';
import 'date_list_widget.dart';

class ArticleListPage extends StatelessWidget {
  @override
  Widget build(BuildContext _) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(
              builder: (context) => SizedBox(
                height: DefaultTextStyle.of(context).style.fontSize *
                    MediaQuery.of(context).textScaleFactor *
                    3,
                child: const DateListWidget(),
              ),
            ),
            const ArticleCountWidget(),
            const Expanded(
              child: ArticleListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
