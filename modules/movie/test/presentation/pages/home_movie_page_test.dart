import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';

import '../../helpers/now_playing_bloc.mocks.dart';
import '../../helpers/popular_movies_bloc.mocks.dart';
import '../../helpers/top_rated_movie_bloc.mocks.dart';

void main() {
  final mockNowPlayingBloc = MockNowPlayingBloc();
  final mockPopularMoviesBloc = MockPopularMoviesBloc();
  final mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();

  Widget makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<NowPlayingBloc>(
          create: (context) => mockNowPlayingBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => mockPopularMoviesBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => mockTopRatedMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display progress circular bar when state is loading',
    (tester) async {
      when(() => mockNowPlayingBloc.state).thenReturn(NowPlayingLoading());
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(PopularMoviesLoading());
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      expect(progressBarFinder, findsWidgets);
    },
  );

  testWidgets(
    'should display ListView when data is loaded',
    (tester) async {
      when(() => mockNowPlayingBloc.state).thenReturn(const NowPlayingHasData([]));
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(const PopularMoviesHasData([]));
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(const TopRatedMoviesHasData([]));

      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      expect(listViewFinder, findsWidgets);
    },
  );

  testWidgets(
    'should display text with message when Error',
    (tester) async {
      when(() => mockNowPlayingBloc.state).thenReturn(const NowPlayingError('Error Message'));
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(const PopularMoviesError('Error Message'));
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(const TopRatedMoviesError('Error Message'));

      final textFinder = find.byKey(const Key('error_message'));
      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      expect(textFinder, findsWidgets);
    },
  );
}
