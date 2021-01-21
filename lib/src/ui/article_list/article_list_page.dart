import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:vnnews/src/model/article_model.dart';
import 'package:vnnews/src/services/firestore.dart';
import 'package:vnnews/src/ui/article_view/article_view_page.dart';

class ArticleListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final future = useProvider(articlesProvider(date).future);
    return FutureBuilder<List<ArticleModel>>(
      future: future,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('${snapshot.error}')));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final articles = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('$date (${articles.length})'),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  leading: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(article.metadata.ogImage ?? ''),
                  ),
                  title: Text(
                    article.metadata.ogTitle ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    article.metadata.ogDescription ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ArticleViewPage(article: article))),
                );
              },
              itemCount: articles.length,
            ),
          );
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
