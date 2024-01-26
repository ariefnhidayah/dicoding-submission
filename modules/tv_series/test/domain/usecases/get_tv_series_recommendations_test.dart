import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(repository);
  });

  final id = 1;
  final tvSeries = <TvSeries>[];

  test('Should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(repository.getTvSeriesRecommendations(id))
        .thenAnswer((_) async => Right(tvSeries));
    // act
    final result = await usecase.execute(id);
    // assert
    expect(result, Right(tvSeries));
  });
}
