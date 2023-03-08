import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:neos_post/core/error/failure.dart';
import 'package:neos_post/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:neos_post/feature/domain/usecase/gettopheadlinesnews/get_top_headlines_news.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class TopHeadlinesNewsBloc extends Bloc<TopHeadlinesNewsEvent, TopHeadlinesNewsState> {
  final GetTopHeadlinesNews getTopHeadlinesNews;

  TopHeadlinesNewsBloc({
    @required this.getTopHeadlinesNews
  })  : assert(getTopHeadlinesNews != null),super(InitialTopHeadlinesNewsState()){
    on<LoadTopHeadlinesNewsEvent>(_onLoad);
  }

  Stream<TopHeadlinesNewsState> mapEventToState(
    TopHeadlinesNewsEvent event,
  ) async* {
    if (event is LoadTopHeadlinesNewsEvent) {
      yield* _mapLoadTopHeadlinesNewsEventToState(event);
    } else if (event is ChangeCategoryTopHeadlinesNewsEvent) {
      yield* _mapChangeCategoryTopHeadlinesNewsEventToState(event);
    }
  }

  void _onLoad(
      LoadTopHeadlinesNewsEvent event,
      Emitter<TopHeadlinesNewsState> emit,
      ) async {
    if(event.page == 1) emit(LoadingTopHeadlinesNewsState());

    var response = await getTopHeadlinesNews(ParamsGetTopHeadlinesNews(page: event.page, language: event.language));
    response.fold((failure) {
        if (failure is ServerFailure) {
          // emit(FailureTopHeadlinesNewsState(errorMessage: failure.errorMessage));
          emit(LoadedTopHeadlinesNewsState(listArticles: event.existingData, page: event.page, hasMore: true));
        } else if (failure is ConnectionFailure) {
          emit(FailureTopHeadlinesNewsState(errorMessage: failure.errorMessage));
        }
      },
          (data) {
            print('page: ${event.page}, ${data.length} items fetched');
            var listArticles = <ItemArticleTopHeadlinesNewsResponseModel>[];
            if(event.existingData != null) {
              listArticles.addAll(event.existingData);
            }
            listArticles.addAll(data);
            emit(LoadedTopHeadlinesNewsState(listArticles: listArticles, page: event.page, hasMore: data.isNotEmpty));
        }
    );
  }

  Stream<TopHeadlinesNewsState> _mapLoadTopHeadlinesNewsEventToState(LoadTopHeadlinesNewsEvent event) async* {
    yield LoadingTopHeadlinesNewsState();
    var response = await getTopHeadlinesNews(ParamsGetTopHeadlinesNews(page: event.page, language: event.language));
    yield response.fold(
      // ignore: missing_return
      (failure) {
        if (failure is ServerFailure) {
          return FailureTopHeadlinesNewsState(errorMessage: failure.errorMessage);
        } else if (failure is ConnectionFailure) {
          return FailureTopHeadlinesNewsState(errorMessage: failure.errorMessage);
        }
      },
      (data) => LoadedTopHeadlinesNewsState(listArticles: data, page: event.page),
    );
  }

  Stream<TopHeadlinesNewsState> _mapChangeCategoryTopHeadlinesNewsEventToState(
    ChangeCategoryTopHeadlinesNewsEvent event,
  ) async* {
    yield ChangedCategoryTopHeadlinesNewsState(indexCategorySelected: event.indexCategorySelected);
  }
}
