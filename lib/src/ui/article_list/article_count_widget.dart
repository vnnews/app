import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vnnews/src/model/article_model.dart';

import 'provider.dart';

class ArticleCountWidget extends HookWidget {
  const ArticleCountWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future = useProvider(articlesProvider.future);
    return FutureBuilder<List<ArticleModel>>(
      future: future,
      builder: (_, snapshot) {
        final length = snapshot.data?.length;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(length != null ? 'Articles found: $length' : ''),
        );
      },
    );
  }
}
