import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vnnews/src/model/article_model.dart';

Future<List<ArticleModel>> getArticles(date) async {
  final zeroHourAtGmt7 =
      ((date.millisecondsSinceEpoch + _timestampMsGmt7) ~/ _timestampMsInADay) *
              _timestampMsInADay -
          _timestampMsGmt7;
  final fieldTimestamp = _articlesFieldFirstTimestamp;
  final query = _articlesCollection()
      .where(fieldTimestamp,
          isGreaterThanOrEqualTo:
              Timestamp.fromMillisecondsSinceEpoch(zeroHourAtGmt7))
      .where(fieldTimestamp,
          isLessThan: Timestamp.fromMillisecondsSinceEpoch(
              zeroHourAtGmt7 + _timestampMsInADay))
      .orderBy(fieldTimestamp, descending: true);

  final querySnapshot = await query.get();

  return querySnapshot.docs.map<ArticleModel>((doc) {
    final data = doc.data();
    final article = ArticleModel.fromJson(data);
    return article;
  }).toList(growable: false);
}

const _articlesFieldFirstTimestamp = 'first_timestamp';
const _timestampMsInADay = 86400000;
const _timestampMsGmt7 = 7 * 3600000;

CollectionReference _articlesCollection() =>
    FirebaseFirestore.instance.collection('articles');
