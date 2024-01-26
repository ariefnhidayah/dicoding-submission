import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}