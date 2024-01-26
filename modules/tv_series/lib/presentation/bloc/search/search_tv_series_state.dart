part of 'search_tv_series_bloc.dart';

class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object> get props => [];
}

final class SearchTvSeriesEmpty extends SearchTvSeriesState {}

final class SearchTvSeriesLoading extends SearchTvSeriesState {}

final class SearchTvSeriesError extends SearchTvSeriesState {
  final String message;

  const SearchTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchTvSeriesHasData extends SearchTvSeriesState {
  final List<TvSeries> result;

  const SearchTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
