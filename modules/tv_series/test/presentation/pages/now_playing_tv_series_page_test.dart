import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/now_playing_tv_series_bloc.mocks.dart';

void main() {
  final mockNowPlayingTvSeriesBloc = MockNowPlayingTvSeriesBloc();

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvSeriesBloc>(
      create: (context) => mockNowPlayingTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (tester) async {
      when(() => mockNowPlayingTvSeriesBloc.state)
          .thenReturn(NowPlayingTvSeriesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester
          .pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (tester) async {
      when(() => mockNowPlayingTvSeriesBloc.state)
          .thenReturn(const NowPlayingTvSeriesHasData([]));

      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (tester) async {
      when(() => mockNowPlayingTvSeriesBloc.state)
          .thenReturn(const NowPlayingTvSeriesError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));
      await tester.pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
