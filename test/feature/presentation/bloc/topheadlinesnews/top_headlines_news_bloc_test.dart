import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news_app/core/error/failure.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_news_app/feature/domain/usecase/gettopheadlinesnews/get_top_headlines_news.dart';
import 'package:flutter_news_app/feature/domain/usecase/searchtopheadlinesnews/search_top_headlines_news.dart';
import 'package:flutter_news_app/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockGetTopHeadlinesNews extends Mock implements GetTopHeadlinesNews {}

class MockSearchTopHeadlinesNews extends Mock implements SearchTopHeadlinesNews {}

void main() {
  MockGetTopHeadlinesNews mockGetTopHeadlinesNews;
  MockSearchTopHeadlinesNews mockSearchTopHeadlinesNews;
  TopHeadlinesNewsBloc topHeadlinesNewsBloc;

  setUp(() {
    mockGetTopHeadlinesNews = MockGetTopHeadlinesNews();
    mockSearchTopHeadlinesNews = MockSearchTopHeadlinesNews();
    topHeadlinesNewsBloc = TopHeadlinesNewsBloc(
      getTopHeadlinesNews: mockGetTopHeadlinesNews,
      searchTopHeadlinesNews: mockSearchTopHeadlinesNews,
    );
  });

  tearDown(() {
    topHeadlinesNewsBloc?.close();
  });

  test(
    'make sure that AssertionError will be called when accepting null arguments',
    () async {
      // assert
      expect(
        () => TopHeadlinesNewsBloc(
          getTopHeadlinesNews: null,
          searchTopHeadlinesNews: mockSearchTopHeadlinesNews,
        ),
        throwsAssertionError,
      );
      expect(
        () => TopHeadlinesNewsBloc(
          getTopHeadlinesNews: mockGetTopHeadlinesNews,
          searchTopHeadlinesNews: null,
        ),
        throwsAssertionError,
      );
    },
  );

  test(
    'make sure that initialState must be InitialTopHeadlinesNewsState',
    () async {
      // assert
      expect(topHeadlinesNewsBloc.initialState, InitialTopHeadlinesNewsState());
    },
  );

  test(
    'make sure that no state are emitted when TopHeadlinesNewsBloc is closed',
    () async {
      // act
      await topHeadlinesNewsBloc.close();

      // assert
      await expectLater(topHeadlinesNewsBloc, emitsInOrder([InitialTopHeadlinesNewsState(), emitsDone]));
    },
  );

  group('LoadTopHeadlinesNews', () {
    final tCategory = 'technology';
    final tTopHeadlinesNewsResponseModel = <ItemArticleTopHeadlinesNewsResponseModel>[];

    test(
      'make sure that the GetTopHeadlinesNews use case is really called',
      () async {
        // arrange
        when(mockGetTopHeadlinesNews(any)).thenAnswer((_) async => Right(tTopHeadlinesNewsResponseModel));

        // act
        topHeadlinesNewsBloc.add(LoadTopHeadlinesNewsEvent(page: 1, language: tCategory));
        await untilCalled(mockGetTopHeadlinesNews(any));

        // assert
        verify(mockGetTopHeadlinesNews(ParamsGetTopHeadlinesNews(page: 1, language: tCategory)));
      },
    );

  });

  group('ChangeCategoryTopHeadlinesNews', () {
  });

  group('SearchTopHeadlinesNews', () {
    final tKeyword = 'testKeyword';
    final tTopHeadlinesNewsResponseModel = TopHeadlinesNewsResponseModel.fromJson(
      json.decode(
        fixture('top_headlines_news_response_model.json'),
      ),
    );

    test(
      'make sure that the SearchTopHeadlinesNews use case is really called',
      () async {
        // arrange
        when(mockSearchTopHeadlinesNews(any)).thenAnswer((_) async => Right(tTopHeadlinesNewsResponseModel));

        // act
        topHeadlinesNewsBloc.add(SearchTopHeadlinesNewsEvent(keyword: tKeyword));
        await untilCalled(mockSearchTopHeadlinesNews(any));

        // assert
        verify(mockSearchTopHeadlinesNews(ParamsSearchTopHeadlinesNews(keyword: tKeyword)));
      },
    );
  });
}
