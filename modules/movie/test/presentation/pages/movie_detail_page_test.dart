import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/movie_detail_bloc.mocks.dart';
import '../../helpers/movie_detail_recommendation_bloc.mocks.dart';
import '../../helpers/movie_detail_watchlist_status_bloc.mocks.dart';

void main() {
  final mockMovieDetailBloc = MockMovieDetailBloc();
  final mockMovieDetailRecommendationBloc = MockMovieDetailRecommendationBloc();
  final mockMovieDetailWatchlistStatusBloc =
      MockMovieDetailWatchlistStatusBloc();

  Widget makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieDetailRecommendationBloc>(
          create: (context) => mockMovieDetailRecommendationBloc,
        ),
        BlocProvider<MovieDetailWatchlistStatusBloc>(
          create: (context) => mockMovieDetailWatchlistStatusBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when movie not added to watchlist',
    (tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieDetailRecommendationBloc.state)
          .thenReturn(const MovieDetailRecommendationHasData([]));
      when(() => mockMovieDetailWatchlistStatusBloc.state)
          .thenReturn(const MovieDetailWatchlistStatusHasData(false, ''));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should dispay check icon when movie is added to wathclist',
    (tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieDetailRecommendationBloc.state)
          .thenReturn(const MovieDetailRecommendationHasData([]));
      when(() => mockMovieDetailWatchlistStatusBloc.state)
          .thenReturn(const MovieDetailWatchlistStatusHasData(true, ''));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display progress circular bar when state is loading',
    (tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());

      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display DetailContent & progress circular bar in recommendation section when data is loaded & recommendation is loading',
    (tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieDetailWatchlistStatusBloc.state)
          .thenReturn(const MovieDetailWatchlistStatusHasData(false, ''));
      when(() => mockMovieDetailRecommendationBloc.state)
          .thenReturn(MovieDetailRecommendationLoading());

      final detailContentFinder = find.byType(DetailContent);
      final progressBarFinder = find.byType(CircularProgressIndicator);
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(detailContentFinder, findsOneWidget);
      expect(progressBarFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display DetailContent when data is loaded & recommendation is loaded',
    (tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMovieDetailWatchlistStatusBloc.state)
          .thenReturn(const MovieDetailWatchlistStatusHasData(false, ''));
      when(() => mockMovieDetailRecommendationBloc.state)
          .thenReturn(const MovieDetailRecommendationHasData([]));

      final detailContentFinder = find.byType(DetailContent);
      final recommendationListViewFinder = find.byType(ListView);
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(detailContentFinder, findsOneWidget);
      expect(recommendationListViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display error when get data is unsuccessfully',
    (tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(const MovieDetailError("Error Message"));

      final errorKeyFinder = find.byKey(const Key("error_message"));
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(errorKeyFinder, findsOneWidget);
    },
  );
}
