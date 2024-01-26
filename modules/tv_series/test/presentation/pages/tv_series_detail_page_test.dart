import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_series_detail_bloc.mocks.dart';
import '../../helpers/tv_series_recommendation_bloc.mocks.dart';
import '../../helpers/tv_series_watchlist_status_bloc.mocks.dart';

void main() {
  final mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
  final mockTvSeriesRecommendationBloc = MockTvSeriesRecommendationBloc();
  final mockTvSeriesWatchlistStatusBloc = MockTvSeriesWatchlistStatusBloc();

  Widget makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (context) => mockTvSeriesDetailBloc,
        ),
        BlocProvider<TvSeriesRecommendationBloc>(
          create: (context) => mockTvSeriesRecommendationBloc,
        ),
        BlocProvider<TvSeriesWatchlistStatusBloc>(
          create: (context) => mockTvSeriesWatchlistStatusBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when TvSeries not added to watchlist',
    (tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
      when(() => mockTvSeriesRecommendationBloc.state)
          .thenReturn(const TvSeriesRecommendationHasData([]));
      when(() => mockTvSeriesWatchlistStatusBloc.state)
          .thenReturn(const TvSeriesWatchlistStatusHasData(false, ''));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should dispay check icon when TvSeries is added to wathclist',
    (tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
      when(() => mockTvSeriesRecommendationBloc.state)
          .thenReturn(const TvSeriesRecommendationHasData([]));
      when(() => mockTvSeriesWatchlistStatusBloc.state)
          .thenReturn(const TvSeriesWatchlistStatusHasData(true, ''));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display progress circular bar when state is loading',
    (tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailLoading());

      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);
      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display DetailContent & progress circular bar in recommendation section when data is loaded & recommendation is loading',
    (tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
      when(() => mockTvSeriesWatchlistStatusBloc.state)
          .thenReturn(const TvSeriesWatchlistStatusHasData(false, ''));
      when(() => mockTvSeriesRecommendationBloc.state)
          .thenReturn(TvSeriesRecommendationLoading());

      final detailContentFinder = find.byType(DetailContentTvSeries);
      final progressBarFinder = find.byType(CircularProgressIndicator);
      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(detailContentFinder, findsOneWidget);
      expect(progressBarFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display DetailContent when data is loaded & recommendation is loaded',
    (tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
      when(() => mockTvSeriesWatchlistStatusBloc.state)
          .thenReturn(const TvSeriesWatchlistStatusHasData(false, ''));
      when(() => mockTvSeriesRecommendationBloc.state)
          .thenReturn(const TvSeriesRecommendationHasData([]));

      final detailContentFinder = find.byType(DetailContentTvSeries);
      final recommendationListViewFinder = find.byType(ListView);
      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(detailContentFinder, findsOneWidget);
      expect(recommendationListViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display error when get data is unsuccessfully',
    (tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(const TvSeriesDetailError("Error Message"));

      final errorKeyFinder = find.byKey(const Key("error_message"));
      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(errorKeyFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display season list when tv series have season',
    (tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
      when(() => mockTvSeriesWatchlistStatusBloc.state)
          .thenReturn(const TvSeriesWatchlistStatusHasData(false, ''));
      when(() => mockTvSeriesRecommendationBloc.state)
          .thenReturn(const TvSeriesRecommendationHasData([]));

      final seasonCardListFinder = find.byType(SeasonCardList);
      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(seasonCardListFinder, findsWidgets);
    },
  );
}
