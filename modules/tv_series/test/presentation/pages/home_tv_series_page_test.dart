import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/now_playing_tv_series_bloc.mocks.dart';
import '../../helpers/popular_tv_series_bloc.mocks.dart';
import '../../helpers/top_rated_tv_series_bloc.mocks.dart';

void main() {
  final mockNowPlayingTvSeriesBloc = MockNowPlayingTvSeriesBloc();
  final mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();
  final mockTopRatedTvSeriesBloc = MockTopRatedTvSeriesBloc();

  Widget makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<NowPlayingTvSeriesBloc>(
          create: (context) => mockNowPlayingTvSeriesBloc,
        ),
        BlocProvider<PopularTvSeriesBloc>(
          create: (context) => mockPopularTvSeriesBloc,
        ),
        BlocProvider<TopRatedTvSeriesBloc>(
          create: (context) => mockTopRatedTvSeriesBloc,
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
      when(() => mockNowPlayingTvSeriesBloc.state)
          .thenReturn(NowPlayingTvSeriesLoading());
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(PopularTvSeriesLoading());
      when(() => mockTopRatedTvSeriesBloc.state)
          .thenReturn(TopRatedTvSeriesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      await tester.pumpWidget(makeTestableWidget(const HomeTvSeriesPage()));

      expect(progressBarFinder, findsWidgets);
    },
  );

  testWidgets(
    'should display ListView when data is loaded',
    (tester) async {
      when(() => mockNowPlayingTvSeriesBloc.state)
          .thenReturn(const NowPlayingTvSeriesHasData([]));
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(const PopularTvSeriesHasData([]));
      when(() => mockTopRatedTvSeriesBloc.state)
          .thenReturn(const TopRatedTvSeriesHasData([]));

      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(makeTestableWidget(const HomeTvSeriesPage()));

      expect(listViewFinder, findsWidgets);
    },
  );

  testWidgets(
    'should display text with message when Error',
    (tester) async {
      when(() => mockNowPlayingTvSeriesBloc.state)
          .thenReturn(const NowPlayingTvSeriesError('Error Message'));
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(const PopularTvSeriesError('Error Message'));
      when(() => mockTopRatedTvSeriesBloc.state)
          .thenReturn(const TopRatedTvSeriesError('Error Message'));

      final textFinder = find.byKey(const Key('error_message'));
      await tester.pumpWidget(makeTestableWidget(const HomeTvSeriesPage()));

      expect(textFinder, findsWidgets);
    },
  );
}
