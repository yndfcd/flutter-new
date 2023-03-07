import 'package:equatable/equatable.dart';
import 'package:neos_post/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:meta/meta.dart';

abstract class TopHeadlinesNewsEvent extends Equatable {
  const TopHeadlinesNewsEvent();
}

class LoadTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final int page;
  final String language;
  List<ItemArticleTopHeadlinesNewsResponseModel> existingData = <ItemArticleTopHeadlinesNewsResponseModel>[];

  LoadTopHeadlinesNewsEvent({@required this.page, @required this.language, this.existingData});

  @override
  String toString() {
    return 'LoadTopHeadlinesNewsEvent{page: $page}';
  }

  @override
  List<Object> get props => [page, language];
}

class ChangeCategoryTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final int indexCategorySelected;

  ChangeCategoryTopHeadlinesNewsEvent({@required this.indexCategorySelected});

  @override
  List<Object> get props => [indexCategorySelected];

  @override
  String toString() {
    return 'ChangeCategoryTopHeadlinesNewsEvent{indexCategorySelected: $indexCategorySelected}';
  }
}

class SearchTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final String keyword;

  SearchTopHeadlinesNewsEvent({@required this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchTopHeadlinesNewsEvent{keyword: $keyword}';
  }
}