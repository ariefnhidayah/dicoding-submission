import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingBloc(this._getNowPlayingMovies) : super(NowPlayingEmpty()) {
    on<FetchNowPlaying>((event, emit) async {
      emit(NowPlayingLoading());

      final result = await _getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(NowPlayingError(failure.message));
      }, (data) {
        emit(NowPlayingHasData(data));
      });
    });
  }
}
