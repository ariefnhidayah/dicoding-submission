import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecases/get_detail_season.dart';

part 'season_detail_event.dart';
part 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final GetDetailSeason _getDetailSeason;

  SeasonDetailBloc(this._getDetailSeason) : super(SeasonDetailEmpty()) {
    on<FetchSeasonDetail>((event, emit) async {
      emit(SeasonDetailLoading());

      final result =
          await _getDetailSeason.execute(event.tvSeriesID, event.seasonNumber);

      result.fold(
        (failure) {
          emit(SeasonDetailError(failure.message));
        },
        (data) {
          emit(SeasonDetailHasData(data));
        },
      );
    });
  }
}
