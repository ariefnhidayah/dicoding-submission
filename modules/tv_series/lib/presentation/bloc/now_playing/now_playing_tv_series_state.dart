part of 'now_playing_tv_series_bloc.dart';

class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();

  @override
  List<Object> get props => [];
}

final class NowPlayingTvSeriesEmpty extends NowPlayingTvSeriesState {}

final class NowPlayingTvSeriesLoading extends NowPlayingTvSeriesState {}

final class NowPlayingTvSeriesError extends NowPlayingTvSeriesState {
  final String message;

  const NowPlayingTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

final class NowPlayingTvSeriesHasData extends NowPlayingTvSeriesState {
  final List<TvSeries> result;

  const NowPlayingTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
