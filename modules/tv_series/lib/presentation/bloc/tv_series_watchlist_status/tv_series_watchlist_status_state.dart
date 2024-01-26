part of 'tv_series_watchlist_status_bloc.dart';

class TvSeriesWatchlistStatusState extends Equatable {
  const TvSeriesWatchlistStatusState();

  @override
  List<Object> get props => [];
}

final class TvSeriesWatchlistStatusEmpty extends TvSeriesWatchlistStatusState {}

final class TvSeriesWatchlistStatusHasData
    extends TvSeriesWatchlistStatusState {
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistAddSuccessMessage = 'Added to Watchlist';
  final String watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  const TvSeriesWatchlistStatusHasData(this.isAddedToWatchlist, this.message);

  @override
  List<Object> get props => [
        isAddedToWatchlist,
        message,
        watchlistAddSuccessMessage,
        watchlistRemoveSuccessMessage,
      ];
}
