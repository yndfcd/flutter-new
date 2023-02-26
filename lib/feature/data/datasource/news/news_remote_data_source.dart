import 'package:dio/dio.dart';
import 'package:flutter_news_app/config/constant_config.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

abstract class NewsRemoteDataSource {
  /// Calls the [baseUrl]/v2/top-headlines?category=:category&country=:country&apiKey=:apiKey endpoint
  ///
  /// Throws a [DioError] for all error codes.
  Future<List<ItemArticleTopHeadlinesNewsResponseModel>> getTopHeadlinesNews(int page, String language);

  /// Calls the [baseUrl]/v2/top-headlines?country=:country&apiKey=:apiKey&q=:q
  ///
  /// Throws a [DioError] for all error codes.
  Future<TopHeadlinesNewsResponseModel> searchTopHeadlinesNews(String keyword);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;
  final ConstantConfig constantConfig;

  NewsRemoteDataSourceImpl({
    @required this.dio,
    @required this.constantConfig,
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

  @override
  Future<TopHeadlinesNewsResponseModel> searchTopHeadlinesNews(String keyword) async {
    var response = await dio.get(
      '/v2/top-headlines',
      queryParameters: {
        'country': 'id',
        'apiKey': constantConfig.keyNewsApi,
        'q': keyword,
      },
    );
    if (response.statusCode == 200) {
      return TopHeadlinesNewsResponseModel.fromJson(response.data);
    } else {
      throw DioError();
    }
  }
}
