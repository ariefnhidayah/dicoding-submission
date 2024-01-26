import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/popular_tv_series_bloc.mocks.dart';

void main() {
  final mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>(
      create: (context) => mockPopularTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (tester) async {
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(PopularTvSeriesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (tester) async {
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(const PopularTvSeriesHasData([]));

      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (tester) async {
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(const PopularTvSeriesError('Error Message'));

      final textFinder = find.byKey(const Key('error_message'));
      await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
