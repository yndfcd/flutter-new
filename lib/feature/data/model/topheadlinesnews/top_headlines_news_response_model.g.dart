// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_headlines_news_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopHeadlinesNewsResponseModel _$TopHeadlinesNewsResponseModelFromJson(
    Map<String, dynamic> json) {
  return TopHeadlinesNewsResponseModel(
    status: json['status'] as String,
    totalResults: json['totalResults'] as int,
    articles: (json['articles'] as List)
        ?.map((e) => e == null
            ? null
            : ItemArticleTopHeadlinesNewsResponseModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TopHeadlinesNewsResponseModelToJson(
        TopHeadlinesNewsResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

ItemArticleTopHeadlinesNewsResponseModel _$ItemArticleTopHeadlinesNewsFromJson(
    Map<String, dynamic> json) {
  return ItemArticleTopHeadlinesNewsResponseModel(
    id: json['id'] as int,
    author: json['author'] as String,
    subject: json['subject'] as String,
    summary: json['summary'] as String,
    url: json['url'] as String,
    url2image: json['urlToImage'] as String,
    pub_datetime: json['publishedAt'] as String
  );
}

Map<String, dynamic> _$ItemArticleTopHeadlinesNewsToJson(
        ItemArticleTopHeadlinesNewsResponseModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'subject': instance.subject,
      'summary': instance.summary,
      'url': instance.url,
      'url2Image': instance.url2image,
      'pub_datetime': instance.pub_datetime
    };

ItemSourceTopHeadlinesNewsResponseModel _$ItemSourceTopHeadlinesNewsFromJson(
    Map<String, dynamic> json) {
  return ItemSourceTopHeadlinesNewsResponseModel(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ItemSourceTopHeadlinesNewsToJson(
        ItemSourceTopHeadlinesNewsResponseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
