import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_recommendation_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvSeriesRecommendationBloc tvSeriesRecommendationBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesRecommendationBloc =
        TvSeriesRecommendationBloc(mockGetTvSeriesRecommendations);
  });

  test('intiial state should be empty', () {
    expect(tvSeriesRecommendationBloc.state, TvSeriesRecommendationEmpty());
  });

  final tvSeriesList = <TvSeries>[testTvSeries];

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'should emit [Loading, HasData] when data is get successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(1))
          .thenAnswer((_) async => Right(tvSeriesList));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesRecommendation(1)),
    expect: () => [
      TvSeriesRecommendationLoading(),
      TvSeriesRecommendationHasData(tvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(1));
    },
  );

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'should emit [Loading, Error] when data is get unsuccessfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesRecommendation(1)),
    expect: () => [
      TvSeriesRecommendationLoading(),
      const TvSeriesRecommendationError("Server Failure")
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(1));
    },
  );
}
