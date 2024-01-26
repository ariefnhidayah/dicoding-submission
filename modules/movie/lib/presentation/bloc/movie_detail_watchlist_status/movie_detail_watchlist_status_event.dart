part of 'movie_detail_watchlist_status_bloc.dart';

sealed class MovieDetailWatchlistStatusEvent extends Equatable {
  const MovieDetailWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

final class FetchWatchlistStatus extends MovieDetailWatchlistStatusEvent {
  final int id;

  const FetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

final class AddWatchlistMovie extends MovieDetailWatchlistStatusEvent {
  final MovieDetail data;

  const AddWatchlistMovie(this.data);

  @override
  List<Object> get props => [data];
}

final class RemoveWatchlistMovie extends MovieDetailWatchlistStatusEvent {
  final MovieDetail data;

  const RemoveWatchlistMovie(this.data);

  @override
  List<Object> get props => [data];
}

final class ResetMessage extends MovieDetailWatchlistStatusEvent {
  final bool isAddedWatchlist;

  const ResetMessage(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}
