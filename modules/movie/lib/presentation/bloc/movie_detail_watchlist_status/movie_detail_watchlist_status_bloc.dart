import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'movie_detail_watchlist_status_event.dart';
part 'movie_detail_watchlist_status_state.dart';

class MovieDetailWatchlistStatusBloc extends Bloc<
    MovieDetailWatchlistStatusEvent, MovieDetailWatchlistStatusState> {
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailWatchlistStatusBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(MovieDetailWatchlistStatusEmpty()) {
    on<FetchWatchlistStatus>((event, emit) async {
      final result = await _getWatchListStatus.execute(event.id);

      emit(MovieDetailWatchlistStatusHasData(result, ''));
    });

    on<AddWatchlistMovie>((event, emit) async {
      final result = await _saveWatchlist.execute(event.data);
      String message = '';
      result.fold(
        (failure) {
          message = failure.message;
        },
        (successMessage) {
          message = successMessage;
        },
      );

      final fetchStatus = await _getWatchListStatus.execute(event.data.id);
      emit(MovieDetailWatchlistStatusHasData(fetchStatus, message));
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final result = await _removeWatchlist.execute(event.data);
      String message = '';
      result.fold(
        (failure) {
          message = failure.message;
        },
        (successMessage) {
          message = successMessage;
        },
      );

      final fetchStatus = await _getWatchListStatus.execute(event.data.id);
      emit(MovieDetailWatchlistStatusHasData(fetchStatus, message));
    });

    on<ResetMessage>((event, emit) async {
      emit(MovieDetailWatchlistStatusHasData(event.isAddedWatchlist, ''));
    });
  }
}
