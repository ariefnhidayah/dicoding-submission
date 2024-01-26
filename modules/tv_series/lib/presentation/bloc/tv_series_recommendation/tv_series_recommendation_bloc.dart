import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;

  TvSeriesRecommendationBloc(this._getTvSeriesRecommendations)
      : super(TvSeriesRecommendationEmpty()) {
    on<FetchTvSeriesRecommendation>((event, emit) async {
      emit(TvSeriesRecommendationLoading());

      final result = await _getTvSeriesRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(TvSeriesRecommendationError(failure.message));
        },
        (data) {
          emit(TvSeriesRecommendationHasData(data));
        },
      );
    });
  }
}
