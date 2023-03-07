import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:neos_post/core/error/failure.dart';
import 'package:neos_post/core/network/network_info.dart';
import 'package:neos_post/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:neos_post/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:neos_post/feature/domain/repository/news/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    @required this.newsRemoteDataSource,
    @required this.networkInfo,
  });

  Future<String> getFileData() async {
    return await rootBundle.loadString('assets/data/news.json');
  }

  @override
  Future<Either<Failure, List<ItemArticleTopHeadlinesNewsResponseModel>>> getTopHeadlinesNews(int page, String language) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await newsRemoteDataSource.getTopHeadlinesNews(page, language);
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, TopHeadlinesNewsResponseModel>> searchTopHeadlinesNews(String keyword) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await newsRemoteDataSource.searchTopHeadlinesNews(keyword);
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
