import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:vnnews/src/model/article_model.dart';
import 'package:vnnews/src/ui/article_view/article_view_page.dart';

import 'provider.dart';

class ArticleListWidget extends HookWidget {
  const ArticleListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future = useProvider(articlesProvider.future);
    return FutureBuilder<List<ArticleModel>>(
      future: future,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${snapshot.error}'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final articles = snapshot.data;
          return ListView.builder(
            itemBuilder: (_, index) =>
                _ArticleListItem(article: articles[index]),
            itemCount: articles.length,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _ArticleListItem extends StatelessWidget {
  final ArticleModel article;

  const _ArticleListItem({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          article.metadata.ogImage ?? '',
          fit: BoxFit.cover,
        ),
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
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ArticleViewPage(article: article))),
    );
  }
}
