import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';

class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}