
import 'package:dio/dio.dart';
import 'package:neos_post/config/constant_config.dart';
import 'package:neos_post/core/network/network_info.dart';
import 'package:neos_post/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:neos_post/feature/data/repository/news/news_repository_impl.dart';
import 'package:neos_post/feature/domain/repository/news/news_repository.dart';
import 'package:neos_post/feature/domain/usecase/gettopheadlinesnews/get_top_headlines_news.dart';
import 'package:neos_post/feature/domain/usecase/searchtopheadlinesnews/search_top_headlines_news.dart';
import 'package:neos_post/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc
  sl.registerFactory(
    () => TopHeadlinesNewsBloc(
      getTopHeadlinesNews: sl(),
      searchTopHeadlinesNews: sl(),
    ),
  );

  // Use Case
  sl.registerLazySingleton(() => GetTopHeadlinesNews(newsRepository: sl()));
  sl.registerLazySingleton(() => SearchTopHeadlinesNews(newsRepository: sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(newsRemoteDataSource: sl(), networkInfo: sl()));

  // Data Source
  sl.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(dio: sl(), constantConfig: sl()));

  /**
   * ! Core
   */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  /**
   * ! External
   */
  sl.registerLazySingleton(() {
    final dio = Dio();
    // dio.options.baseUrl = FlavorConfig.instance.values.baseUrl;
    // dio.interceptors.add(DioLoggingInterceptor());
    return dio;
  });
  sl.registerLazySingleton(() => ConstantConfig());
}
