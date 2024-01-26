import 'dart:convert';

import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  TvSeriesModel tvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: '/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg',
    genreIds: [10763],
    id: 94722,
    originCountry: ['DE'],
    originalLanguage: 'de',
    originalName: 'Tagesschau',
    overview:
        'German daily news program, the oldest still existing program on German television.',
    popularity: 3371.629,
    posterPath: '/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg',
    firstAirDate: '1952-12-26',
    name: 'Tagesschau',
    voteAverage: 6.932,
    voteCount: 190,
  );

  final tvSeriesResponseModel = TvSeriesResponse(tvSeries: [tvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv_series.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
            "genre_ids": [10763],
            "id": 94722,
            "origin_country": ["DE"],
            "original_language": "de",
            "original_name": "Tagesschau",
            "overview":
                "German daily news program, the oldest still existing program on German television.",
            "popularity": 3371.629,
            "poster_path": "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
            "first_air_date": "1952-12-26",
            "name": "Tagesschau",
            "vote_average": 6.932,
            "vote_count": 190
          }
        ]
      };

      expect(result, expectedJsonMap);
    });
  });
}
