import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/tv_series.dart';

class MockWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}
