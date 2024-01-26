import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(repository);
  });

  final tvSeriesList = <TvSeries>[];

  test("should get watchlist of tv series from the repository", () async {
    // arrange
    when(repository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(tvSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tvSeriesList));
  });
}
