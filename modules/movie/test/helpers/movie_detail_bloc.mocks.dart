import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}