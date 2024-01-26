import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/watchlist_tv_series_bloc.mocks.dart';

void main() {
  final mockWatchlistTvSeriesBloc = MockWatchlistTvSeriesBloc();

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvSeriesBloc>(
      create: (context) => mockWatchlistTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (tester) async {
      when(() => mockWatchlistTvSeriesBloc.state)
          .thenReturn(WatchlistTvSeriesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester
          .pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (tester) async {
      when(() => mockWatchlistTvSeriesBloc.state)
          .thenReturn(const WatchlistTvSeriesHasData([]));

      final listViewFinder = find.byType(ListView);
      await tester
          .pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (tester) async {
      when(() => mockWatchlistTvSeriesBloc.state)
          .thenReturn(const WatchlistTvSeriesError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));
      await tester
          .pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display TvCardList when data is loaded',
    (tester) async {
      when(() => mockWatchlistTvSeriesBloc.state)
          .thenReturn(WatchlistTvSeriesHasData([testTvSeries]));

      final listViewFinder = find.byType(TvCardList);
      await tester
          .pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

      expect(listViewFinder, findsWidgets);
    },
  );
}
