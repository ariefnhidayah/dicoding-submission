import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';

class MockWatchlistMovieBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}