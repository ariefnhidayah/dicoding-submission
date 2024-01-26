import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../helpers/top_rated_movie_bloc.mocks.dart';

void main() {
  final mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>(
      create: (context) => mockTopRatedMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (tester) async {
      when(() => mockTopRatedMoviesBloc.state).thenReturn(TopRatedMoviesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (tester) async {
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(const TopRatedMoviesHasData([]));

      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (tester) async {
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(const TopRatedMoviesError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));
      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}