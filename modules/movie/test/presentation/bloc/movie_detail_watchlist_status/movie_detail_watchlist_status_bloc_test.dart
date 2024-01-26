import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailWatchlistStatusBloc movieDetailWatchlistStatusBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailWatchlistStatusBloc = MovieDetailWatchlistStatusBloc(
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state should be empty', () {
    expect(movieDetailWatchlistStatusBloc.state,
        MovieDetailWatchlistStatusEmpty());
  });

  blocTest<MovieDetailWatchlistStatusBloc, MovieDetailWatchlistStatusState>(
    'should emit [Has Data] when data is gotten successfully',
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return movieDetailWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistStatus(1)),
    expect: () => [
      const MovieDetailWatchlistStatusHasData(true, ''),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(1));
    },
  );

  blocTest<MovieDetailWatchlistStatusBloc, MovieDetailWatchlistStatusState>(
    'should emit [Has Data] when data is added to watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return movieDetailWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
    expect: () => [
      const MovieDetailWatchlistStatusHasData(true, 'Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailWatchlistStatusBloc, MovieDetailWatchlistStatusState>(
    'should emit [Has Data] when data is removed from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return movieDetailWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
    expect: () => [
      const MovieDetailWatchlistStatusHasData(false, 'Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailWatchlistStatusBloc, MovieDetailWatchlistStatusState>(
    'should emit [HasData] and delete message when call event ResetMessage',
    build: () {
      return movieDetailWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(const ResetMessage(true)),
    expect: () => [
      const MovieDetailWatchlistStatusHasData(true, ''),
    ],
  );

  blocTest<MovieDetailWatchlistStatusBloc, MovieDetailWatchlistStatusState>(
    'should emit error when failure add watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Error')));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return movieDetailWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
    expect: () => [
      const MovieDetailWatchlistStatusHasData(false, 'Error'),
    ],
  );

  blocTest<MovieDetailWatchlistStatusBloc, MovieDetailWatchlistStatusState>(
    'should emit error when failure remove watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Error')));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return movieDetailWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
    expect: () => [
      const MovieDetailWatchlistStatusHasData(false, 'Error'),
    ],
  );
}
