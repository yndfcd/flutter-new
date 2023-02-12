import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'top_headlines_news_response_model.g.dart';

@JsonSerializable()
class TopHeadlinesNewsResponseModel extends Equatable {
  final String status;
  final int totalResults;
  final List<ItemArticleTopHeadlinesNewsResponseModel> articles;

  TopHeadlinesNewsResponseModel({
    @required this.status,
    @required this.totalResults,
    @required this.articles,
  });

  factory TopHeadlinesNewsResponseModel.fromJson(Map<String, dynamic> json) => _$TopHeadlinesNewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopHeadlinesNewsResponseModelToJson(this);

  @override
  List<Object> get props => [status, totalResults, articles];

  @override
  String toString() {
    return 'TopHeadlinesNewsResponseModel{status: $status, totalResults: $totalResults, articles: $articles}';
  }
}

@JsonSerializable()
class ItemArticleTopHeadlinesNewsResponseModel extends Equatable {
  final String author;
  final int id;
  final String subject;
  final String summary;
  final String url;
  final String url2image;
  final String pub_datetime;

  ItemArticleTopHeadlinesNewsResponseModel({
    @required this.author,
    @required this.id,
    @required this.subject,
    @required this.summary,
    @required this.url,
    @required this.url2image,
    @required this.pub_datetime
  });

  factory ItemArticleTopHeadlinesNewsResponseModel.fromJson(Map<String, dynamic> json) => _$ItemArticleTopHeadlinesNewsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemArticleTopHeadlinesNewsToJson(this);

  @override
  List<Object> get props => [author, id, subject, summary, url, url2image, pub_datetime];

  @override
  String toString() {
    return 'ItemArticleTopHeadlinesNewsResponseModel{ author: $author, title: $subject, description: $summary, url: $url, urlToImage: $url2image, publishedAt: $pub_datetime}';
  }
}

@JsonSerializable()
class ItemSourceTopHeadlinesNewsResponseModel extends Equatable {
  final String name;

  ItemSourceTopHeadlinesNewsResponseModel({@required this.name});

  factory ItemSourceTopHeadlinesNewsResponseModel.fromJson(Map<String, dynamic> json) => _$ItemSourceTopHeadlinesNewsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSourceTopHeadlinesNewsToJson(this);

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return 'ItemSourceTopHeadlinesNewsResponseModel{name: $name}';
  }
}
