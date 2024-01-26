import 'dart:convert';

import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/models/season_detail_model.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get Now Playing Tv Series', () {
    final tvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing_tv_series.json')))
        .tvSeries;

    test('should return list of TvSeriesModel when the response is success',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer(
        (_) async => http.Response(
            readJson('dummy_data/now_playing_tv_series.json'), 200),
      );
      // act
      final result = await dataSource.getNowPlayingTvSeries();
      // assert
      expect(result, equals(tvSeriesList));
    });

    test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular Tv Series', () {
    final tvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv_series.json')))
        .tvSeries;

    test('Should return list of TvSeriesModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((realInvocation) async => http.Response(
              readJson('dummy_data/popular_tv_series.json'), 200));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result, tvSeriesList);
    });

    test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated Tv Series', () {
    final tvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv_series.json')))
        .tvSeries;

    test('Should return list of TvSeriesModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((realInvocation) async => http.Response(
              readJson('dummy_data/top_rated_tv_series.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result, tvSeriesList);
    });

    test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Recommendation Tv Series', () {
    final tvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommendations.json')))
        .tvSeries;
    final tvSeriesId = 1;

    test('Should return list of TvSeriesModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tvSeriesId/recommendations?$API_KEY')))
          .thenAnswer((realInvocation) async => http.Response(
              readJson('dummy_data/tv_series_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvSeriesRecommendations(tvSeriesId);
      // assert
      expect(result, tvSeriesList);
    });

    test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tvSeriesId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesRecommendations(tvSeriesId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search TV Series', () {
    final tvSeriesList = TvSeriesResponse.fromJson(json
            .decode(readJson('dummy_data/search_tagesschau_tv_series.json')))
        .tvSeries;
    final query = 'tagesschau';

    test('Should return list of TvSeriesModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((realInvocation) async => http.Response(
              readJson('dummy_data/search_tagesschau_tv_series.json'), 200));
      // act
      final result = await dataSource.searchTvSeries(query);
      // assert
      expect(result, tvSeriesList);
    });

    test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvSeries(query);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Detail TV Series', () {
    final tvSeriesDetail = TvSeriesDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));
    final tvSeriesId = 1;

    test('Should return TvSeriesDetailModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvSeriesId?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/tv_series_detail.json'), 200));
      // act
      final result = await dataSource.getTvSeriesDetail(tvSeriesId);
      // assert
      expect(result, tvSeriesDetail);
    });

    test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvSeriesId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesDetail(tvSeriesId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Detail Season', () {
    final seasonDetail = SeasonDetailModel.fromJson(
        json.decode(readJson("dummy_data/season_detail.json")));
    const tvSeriesID = 1;
    const seasonNumber = 1;

    test('should return SeasonDetailModel when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '$BASE_URL/tv/$tvSeriesID/season/$seasonNumber?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson("dummy_data/season_detail.json"), 200));
      // act
      final result = await dataSource.getDetailSeason(tvSeriesID, seasonNumber);
      // assert
      expect(result, seasonDetail);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '$BASE_URL/tv/$tvSeriesID/season/$seasonNumber?$API_KEY')))
          .thenAnswer(
              (realInvocation) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.getDetailSeason(tvSeriesID, seasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
