import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/pages/season_detail_page.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/season_detail_bloc.mocks.dart';

void main() {
  final mockSeasonDetailBloc = MockSeasonDetailBloc();

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SeasonDetailBloc>(
      create: (context) => mockSeasonDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (tester) async {
      when(() => mockSeasonDetailBloc.state).thenReturn(SeasonDetailLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        tvSeriesID: 1,
        seasonNumber: 1,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display widget DetailContentSeason when data has loaded',
    (tester) async {
      when(() => mockSeasonDetailBloc.state)
          .thenReturn(const SeasonDetailHasData(testSeasonDetail));

      final detailContentSeasonFinder = find.byType(DetailContentSeason);
      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        tvSeriesID: 1,
        seasonNumber: 1,
      )));

      expect(detailContentSeasonFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display error message when get data is error',
    (tester) async {
      when(() => mockSeasonDetailBloc.state)
          .thenReturn(const SeasonDetailError('Error Message'));

      final errorKeyFinder = find.byKey(const Key("error_message"));
      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        tvSeriesID: 1,
        seasonNumber: 1,
      )));

      expect(errorKeyFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display episode card list when season has episodes',
    (tester) async {
      when(() => mockSeasonDetailBloc.state)
          .thenReturn(const SeasonDetailHasData(testSeasonDetail));

      final episodeCardListFinder = find.byType(EpisodeCardList);
      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        tvSeriesID: 1,
        seasonNumber: 1,
      )));

      expect(episodeCardListFinder, findsWidgets);
    },
  );
}
