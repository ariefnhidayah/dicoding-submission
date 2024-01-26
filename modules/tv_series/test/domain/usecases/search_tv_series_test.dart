import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository repository;

  final tvSeries = <TvSeries>[];
  final query = 'One Piece';

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = SearchTvSeries(repository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(repository.searchTvSeries(query))
        .thenAnswer((_) async => Right(tvSeries));
    // act
    final result = await usecase.execute(query);
    // assert
    expect(result, Right(tvSeries));
  });
}
