part of 'tv_series_watchlist_status_bloc.dart';

class TvSeriesWatchlistStatusEvent extends Equatable {
  const TvSeriesWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

final class FetchTvSeriesWatchlistStatus extends TvSeriesWatchlistStatusEvent {
  final int id;

  const FetchTvSeriesWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

final class AddTvSeriesWatchlist extends TvSeriesWatchlistStatusEvent {
  final TvSeriesDetail data;

  const AddTvSeriesWatchlist(this.data);

  @override
  List<Object> get props => [data];
}

final class RemoveTvSeriesWatchlist extends TvSeriesWatchlistStatusEvent {
  final TvSeriesDetail data;

  const RemoveTvSeriesWatchlist(this.data);

  @override
  List<Object> get props => [data];
}

final class ResetMessageWatchlistTvSeries extends TvSeriesWatchlistStatusEvent {
  final bool isAddedWatchlist;

  const ResetMessageWatchlistTvSeries(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}
