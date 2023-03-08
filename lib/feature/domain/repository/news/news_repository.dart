import 'package:dartz/dartz.dart';
import 'package:neos_post/core/error/failure.dart';
import 'package:neos_post/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';

abstract class NewsRepository {

  Future<Either<Failure, List<ItemArticleTopHeadlinesNewsResponseModel>>> getTopHeadlinesNews(int page, String language);

}