part of 'movie_detail_recommendation_bloc.dart';

sealed class MovieDetailRecommendationEvent extends Equatable {
  const MovieDetailRecommendationEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovieRecommendation extends MovieDetailRecommendationEvent {
  final int id;

  const FetchMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
