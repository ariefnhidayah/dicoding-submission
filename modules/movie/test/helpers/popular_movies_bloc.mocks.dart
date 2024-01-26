import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}
