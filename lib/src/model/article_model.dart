import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
abstract class ArticleModel with _$ArticleModel {
  const factory ArticleModel(
    @JsonKey(fromJson: _timestampNoOp, toJson: _timestampNoOp)
    @nullable
        Timestamp timestamp,
    @JsonKey(fromJson: _timestampNoOp, toJson: _timestampNoOp)
    @nullable
        Timestamp firstTimestamp,
    String url,
    String body,
    @nullable bool hasHistory,
    ArticleMetadataModel metadata,
    @nullable List<String> tags,
  ) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}

@freezed
abstract class ArticleMetadataModel with _$ArticleMetadataModel {
  const factory ArticleMetadataModel(
    @JsonKey(name: 'og:description') @nullable String ogDescription,
    @JsonKey(name: 'og:image') @nullable String ogImage,
    @JsonKey(name: 'og:image:height', fromJson: _imageDimensionFromJson)
    @nullable
        int ogImageHeight,
    @JsonKey(name: 'og:image:width', fromJson: _imageDimensionFromJson)
    @nullable
        int ogImageWidth,
    @JsonKey(name: 'og:title') @nullable String ogTitle,
    @JsonKey(name: 'og:url') @nullable String ogUrl,
  ) = _ArticleMetadataModel;

  factory ArticleMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleMetadataModelFromJson(json);
}

int _imageDimensionFromJson(String s) => s == null ? null : int.tryParse(s);

Timestamp _timestampNoOp(Timestamp t) => t;
