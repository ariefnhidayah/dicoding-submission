part of 'tv_series_recommendation_bloc.dart';

class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

final class TvSeriesRecommendationEmpty extends TvSeriesRecommendationState {}

final class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {}

final class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;

  const TvSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvSeriesRecommendationHasData extends TvSeriesRecommendationState {
  final List<TvSeries> result;

  const TvSeriesRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
