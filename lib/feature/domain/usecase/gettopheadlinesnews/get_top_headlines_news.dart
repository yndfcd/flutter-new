import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neos_post/core/error/failure.dart';
import 'package:neos_post/core/usecase/usecase.dart';
import 'package:neos_post/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:neos_post/feature/domain/repository/news/news_repository.dart';
import 'package:meta/meta.dart';

class GetTopHeadlinesNews implements UseCase<List<ItemArticleTopHeadlinesNewsResponseModel>, ParamsGetTopHeadlinesNews> {
  final NewsRepository newsRepository;

  GetTopHeadlinesNews({@required this.newsRepository});

  @override
  Future<Either<Failure, List<ItemArticleTopHeadlinesNewsResponseModel>>> call(ParamsGetTopHeadlinesNews params) async {
    return await newsRepository.getTopHeadlinesNews(params.page, params.language);
  }
}

class ParamsGetTopHeadlinesNews extends Equatable {
  final int page;
  final String language;

  ParamsGetTopHeadlinesNews({@required this.page, @required this.language});

  @override
  List<Object> get props => [page, language];

  @override
  String toString() {
    return 'ParamsGetTopHeadlinesNews{Page: $page, language: $language}';
  }
}