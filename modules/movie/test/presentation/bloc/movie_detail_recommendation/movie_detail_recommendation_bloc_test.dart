import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'movie_detail_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieDetailRecommendationBloc movieDetailRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailRecommendationBloc =
        MovieDetailRecommendationBloc(mockGetMovieRecommendations);
  });

  test('initial state should be empty', () {
    expect(
        movieDetailRecommendationBloc.state, MovieDetailRecommendationEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  blocTest<MovieDetailRecommendationBloc, MovieDetailRecommendationState>(
    'should emit [Loading, Has Data] when data is get successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(tMovieList));
      return movieDetailRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(1)),
    expect: () => [
      MovieDetailRecommendationLoading(),
      MovieDetailRecommendationHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(1));
    },
  );

  blocTest<MovieDetailRecommendationBloc, MovieDetailRecommendationState>(
    'should emit [Loading, Error] when data is get unsuccessfully',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(1)),
    expect: () => [
      MovieDetailRecommendationLoading(),
      const MovieDetailRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(1));
    },
  );
}
