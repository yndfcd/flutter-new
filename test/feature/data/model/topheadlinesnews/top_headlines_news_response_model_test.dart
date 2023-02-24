import 'dart:convert';

import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tItemSourceTopHeadlinesNewsResponseModel = ItemSourceTopHeadlinesNewsResponseModel(name: 'testName');
  final tItemArticleTopHeadlinesNewsResponseModel = ItemArticleTopHeadlinesNewsResponseModel(
    author: 'testAuthor',
    subject: 'testTitle',
    summary: 'testDescription',
    url: 'testUrl',
    url2image: 'testUrlToImage',
    pub_datetime: 'testPublishedAt',
    id: 1
  );
  final tTopHeadlinesNewsResponseModel = TopHeadlinesNewsResponseModel(
    status: 'testStatus',
    totalResults: 1,
    articles: [
      tItemArticleTopHeadlinesNewsResponseModel,
    ],
  );

  test(
    'make sure the props value',
    () async {
      // assert
      expect(
        tTopHeadlinesNewsResponseModel.props,
        [
          tTopHeadlinesNewsResponseModel.status,
          tTopHeadlinesNewsResponseModel.totalResults,
          tTopHeadlinesNewsResponseModel.articles,
        ],
      );
      expect(
        tItemArticleTopHeadlinesNewsResponseModel.props,
        [
          tItemArticleTopHeadlinesNewsResponseModel.author,
          tItemArticleTopHeadlinesNewsResponseModel.subject,
          tItemArticleTopHeadlinesNewsResponseModel.summary,
          tItemArticleTopHeadlinesNewsResponseModel.url,
          tItemArticleTopHeadlinesNewsResponseModel.url2image,
          tItemArticleTopHeadlinesNewsResponseModel.pub_datetime,
        ],
      );
      expect(
        tItemSourceTopHeadlinesNewsResponseModel.props,
        [tItemSourceTopHeadlinesNewsResponseModel.name],
      );
    },
  );

  test(
    'make sure the output of the toString function',
    () async {
      // assert
      expect(
        tItemSourceTopHeadlinesNewsResponseModel.toString(),
        'ItemSourceTopHeadlinesNewsResponseModel{name: ${tItemSourceTopHeadlinesNewsResponseModel.name}}',
      );
      expect(
        tItemArticleTopHeadlinesNewsResponseModel.toString(),
        'ItemArticleTopHeadlinesNewsResponseModel{author: ${tItemArticleTopHeadlinesNewsResponseModel.author}, '
        'title: ${tItemArticleTopHeadlinesNewsResponseModel.subject}, '
        'description: ${tItemArticleTopHeadlinesNewsResponseModel.summary}, '
        'url: ${tItemArticleTopHeadlinesNewsResponseModel.url}, '
        'urlToImage: ${tItemArticleTopHeadlinesNewsResponseModel.url2image}, '
        'publishedAt: ${tItemArticleTopHeadlinesNewsResponseModel.pub_datetime}}',
      );
      expect(
        tTopHeadlinesNewsResponseModel.toString(),
        'TopHeadlinesNewsResponseModel{status: ${tTopHeadlinesNewsResponseModel.status}, '
        'totalResults: ${tTopHeadlinesNewsResponseModel.totalResults}, '
        'articles: ${tTopHeadlinesNewsResponseModel.articles}}',
      );
    },
  );

  group('fromJson', () {
    test(
      'make sure the fromJson function returns a valid model object when reading valid JSON',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('top_headlines_news_response_model.json'));

        // act
        final result = TopHeadlinesNewsResponseModel.fromJson(jsonMap);

        // assert
        expect(result, tTopHeadlinesNewsResponseModel);
      },
    );
  });

  group('toJson', () {
    test(
      'make sure the toJson function returns a JSON value in the form of a '
      'valid map object when converting model data to JSON',
      () async {
        // arrange
        final resultTopHeadlinesNewsResponseModel = tTopHeadlinesNewsResponseModel.toJson();
        final resultItemArticleTopHeadlinesNewsResponseModel = tItemArticleTopHeadlinesNewsResponseModel.toJson();
        final resultItemSourceTopHeadlinesNewsResponseModel = tItemSourceTopHeadlinesNewsResponseModel.toJson();

        // act
        final expectedMapItemSourceTopHeadlinesNewsResponseModel = {
          'name': 'testName',
        };
        final expectedMapItemArticleTopHeadlinesResponseModel = {
          'source': tItemSourceTopHeadlinesNewsResponseModel,
          'author': 'testAuthor',
          'title': 'testTitle',
          'description': 'testDescription',
          'url': 'testUrl',
          'urlToImage': 'testUrlToImage',
          'publishedAt': 'testPublishedAt',
          'content': 'testContent',
        };
        final expectedMapTopHeadlinesNewsResponseModel = {
          'status': 'testStatus',
          'totalResults': 1,
          'articles': [
            tItemArticleTopHeadlinesNewsResponseModel,
          ],
        };

        // assert
        expect(resultTopHeadlinesNewsResponseModel, expectedMapTopHeadlinesNewsResponseModel);
        expect(resultItemArticleTopHeadlinesNewsResponseModel, expectedMapItemArticleTopHeadlinesResponseModel);
        expect(resultItemSourceTopHeadlinesNewsResponseModel, expectedMapItemSourceTopHeadlinesNewsResponseModel);
      },
    );
  });
}
