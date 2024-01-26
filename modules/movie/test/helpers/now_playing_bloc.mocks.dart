import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';

class MockNowPlayingBloc extends MockBloc<NowPlayingEvent, NowPlayingState>
    implements NowPlayingBloc {}
