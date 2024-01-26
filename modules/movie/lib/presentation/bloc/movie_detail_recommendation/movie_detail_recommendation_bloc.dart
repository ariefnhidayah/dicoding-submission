import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_recommendation_event.dart';
part 'movie_detail_recommendation_state.dart';

class MovieDetailRecommendationBloc extends Bloc<MovieDetailRecommendationEvent,
    MovieDetailRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieDetailRecommendationBloc(this._getMovieRecommendations)
      : super(MovieDetailRecommendationEmpty()) {
    on<FetchMovieRecommendation>((event, emit) async {
      emit(MovieDetailRecommendationLoading());

      final result = await _getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(MovieDetailRecommendationError(failure.message));
        },
        (data) {
          emit(MovieDetailRecommendationHasData(data));
        },
      );
    });
  }
}
