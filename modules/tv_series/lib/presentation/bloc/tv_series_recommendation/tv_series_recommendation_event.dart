part of 'tv_series_recommendation_bloc.dart';

class TvSeriesRecommendationEvent extends Equatable {
  const TvSeriesRecommendationEvent();

  @override
  List<Object> get props => [];
}

final class FetchTvSeriesRecommendation extends TvSeriesRecommendationEvent {
  final int id;

  const FetchTvSeriesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
