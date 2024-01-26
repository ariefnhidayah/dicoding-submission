import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/tv_series.dart';

class MockTvSeriesRecommendationBloc
    extends MockBloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState>
    implements TvSeriesRecommendationBloc {}
