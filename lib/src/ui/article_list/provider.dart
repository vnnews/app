import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:vnnews/src/model/article_model.dart';
import 'package:vnnews/src/services/firestore.dart';

final daysProvider =
    ChangeNotifierProvider<ValueNotifier<int>>((_) => ValueNotifier(0));

extension IntExtension on int {
  DateTime get asDate => DateTime.now().subtract(Duration(days: this));
}

final articlesProvider =
    FutureProvider.autoDispose<List<ArticleModel>>((ref) async {
  final date = ref.watch(daysProvider).value.asDate;
  return getArticles(date);
});
