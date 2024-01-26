part of 'movie_detail_recommendation_bloc.dart';

sealed class MovieDetailRecommendationState extends Equatable {
  const MovieDetailRecommendationState();

  @override
  List<Object> get props => [];
}

final class MovieDetailRecommendationEmpty
    extends MovieDetailRecommendationState {}

final class MovieDetailRecommendationLoading
    extends MovieDetailRecommendationState {}

final class MovieDetailRecommendationError
    extends MovieDetailRecommendationState {
  final String message;

  const MovieDetailRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

final class MovieDetailRecommendationHasData
    extends MovieDetailRecommendationState {
  final List<Movie> result;

  const MovieDetailRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
