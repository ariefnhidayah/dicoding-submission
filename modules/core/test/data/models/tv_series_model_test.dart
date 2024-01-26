import 'package:core/data/models/tv_series_model.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

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

  TvSeries tvSeries = TvSeries(
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

  test('should be a subclass of TvSeries entity', () async {
    final result = tvSeriesModel.toEntity();
    expect(result, tvSeries);
  });
}
