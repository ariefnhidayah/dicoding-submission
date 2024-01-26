import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesWatchlistStatusBloc tvSeriesWatchlistStatusBloc;
  late MockGetWatchlistStatusTvSeries mockGetWatchlistStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistStatusTvSeries = MockGetWatchlistStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    tvSeriesWatchlistStatusBloc = TvSeriesWatchlistStatusBloc(
      mockGetWatchlistStatusTvSeries,
      mockSaveWatchlistTvSeries,
      mockRemoveWatchlistTvSeries,
    );
  });

  test('initial state should be empty', () {
    expect(tvSeriesWatchlistStatusBloc.state, TvSeriesWatchlistStatusEmpty());
  });

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
    'should emit [Has Data] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistStatusTvSeries.execute(1))
          .thenAnswer((_) async => true);
      return tvSeriesWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesWatchlistStatus(1)),
    expect: () => [
      const TvSeriesWatchlistStatusHasData(true, ""),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistStatusTvSeries.execute(1));
    },
  );

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
    'should emit [Has Data] when data is added to watchlist',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right("Added to Watchlist"));
      when(mockGetWatchlistStatusTvSeries.execute(testTvSeries.id))
          .thenAnswer((_) async => true);
      return tvSeriesWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(const AddTvSeriesWatchlist(testTvSeriesDetail)),
    expect: () => [
      const TvSeriesWatchlistStatusHasData(true, "Added to Watchlist"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
    },
  );

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
    'should emit [Has Data] when data is removed from watchlist',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      return tvSeriesWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(const RemoveTvSeriesWatchlist(testTvSeriesDetail)),
    expect: () => [
      const TvSeriesWatchlistStatusHasData(false, 'Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
    },
  );

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
    'should emit [HasData] and delete message when call event ResetMessage',
    build: () {
      return tvSeriesWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(const ResetMessageWatchlistTvSeries(true)),
    expect: () => [
      const TvSeriesWatchlistStatusHasData(true, ''),
    ],
  );

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
    'should emit error when failure add watchlist',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Error')));
      when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      return tvSeriesWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(const AddTvSeriesWatchlist(testTvSeriesDetail)),
    expect: () => [
      const TvSeriesWatchlistStatusHasData(false, 'Error'),
    ],
  );

  blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
    'should emit error when failure remove watchlist',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Error')));
      when(mockGetWatchlistStatusTvSeries.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      return tvSeriesWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(const RemoveTvSeriesWatchlist(testTvSeriesDetail)),
    expect: () => [
      const TvSeriesWatchlistStatusHasData(false, 'Error'),
    ],
  );
}
