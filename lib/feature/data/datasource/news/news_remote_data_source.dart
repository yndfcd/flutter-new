import 'package:dio/dio.dart';
import 'package:neos_post/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

abstract class NewsRemoteDataSource {
  /// Calls the [baseUrl]/v2/top-headlines?category=:category&country=:country&apiKey=:apiKey endpoint
  ///
  /// Throws a [DioError] for all error codes.
  Future<List<ItemArticleTopHeadlinesNewsResponseModel>> getTopHeadlinesNews(int page, String language);

}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl({
    @required this.dio
  });

  @override
  Future<List<ItemArticleTopHeadlinesNewsResponseModel>> getTopHeadlinesNews(int page, String language) async {
    var language = Hive.box('settings').get('language').split('_')[0];
    var response = await dio.get('https://whl.xingzhelu.net/api/news/$language/$page');
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => ItemArticleTopHeadlinesNewsResponseModel.fromJson(e)).toList();
    } else {
      throw DioError();
    }
  }
}
