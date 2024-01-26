import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../helpers/now_playing_bloc.mocks.dart';

void main() {
  final mockNowPlayingBloc = MockNowPlayingBloc();

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingBloc>(
      create: (context) => mockNowPlayingBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (tester) async {
      when(() => mockNowPlayingBloc.state).thenReturn(NowPlayingLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (tester) async {
      when(() => mockNowPlayingBloc.state)
          .thenReturn(const NowPlayingHasData([]));

      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (tester) async {
      when(() => mockNowPlayingBloc.state)
          .thenReturn(const NowPlayingError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));
      await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
