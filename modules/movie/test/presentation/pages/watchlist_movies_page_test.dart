import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/watchlist_movie_bloc.mocks.dart';

void main() {
  final mockWatchlistMovieBloc = MockWatchlistMovieBloc();

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>(
      create: (context) => mockWatchlistMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (tester) async {
      when(() => mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (tester) async {
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const WatchlistMovieHasData([]));

      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (tester) async {
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const WatchlistMovieError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));
      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display MovieCard when data is loaded',
    (tester) async {
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(WatchlistMovieHasData([testMovie]));

      final movieCardFinder = find.byType(MovieCard);
      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(movieCardFinder, findsWidgets);
    },
  );
}
