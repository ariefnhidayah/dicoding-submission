part of 'movie_detail_watchlist_status_bloc.dart';

sealed class MovieDetailWatchlistStatusState extends Equatable {
  const MovieDetailWatchlistStatusState();

  @override
  List<Object> get props => [];
}

final class MovieDetailWatchlistStatusEmpty
    extends MovieDetailWatchlistStatusState {}

final class MovieDetailWatchlistStatusHasData
    extends MovieDetailWatchlistStatusState {
  final bool isAddedtoWatchlist;
  final String message;
  final String watchlistAddSuccessMessage = 'Added to Watchlist';
  final String watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  const MovieDetailWatchlistStatusHasData(
      this.isAddedtoWatchlist, this.message);

  @override
  List<Object> get props => [isAddedtoWatchlist, message, watchlistAddSuccessMessage, watchlistRemoveSuccessMessage];
}
