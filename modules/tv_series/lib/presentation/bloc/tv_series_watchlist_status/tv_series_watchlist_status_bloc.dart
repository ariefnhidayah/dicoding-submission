import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_watchlist_status_event.dart';
part 'tv_series_watchlist_status_state.dart';

class TvSeriesWatchlistStatusBloc
    extends Bloc<TvSeriesWatchlistStatusEvent, TvSeriesWatchlistStatusState> {
  final GetWatchlistStatusTvSeries _getWatchlistStatusTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;

  TvSeriesWatchlistStatusBloc(
    this._getWatchlistStatusTvSeries,
    this._saveWatchlistTvSeries,
    this._removeWatchlistTvSeries,
  ) : super(TvSeriesWatchlistStatusEmpty()) {
    on<FetchTvSeriesWatchlistStatus>((event, emit) async {
      final result = await _getWatchlistStatusTvSeries.execute(event.id);
      emit(TvSeriesWatchlistStatusHasData(result, ''));
    });

    on<AddTvSeriesWatchlist>((event, emit) async {
      final result = await _saveWatchlistTvSeries.execute(event.data);
      String message = '';
      result.fold(
        (failure) {
          message = failure.message;
        },
        (successMessage) {
          message = successMessage;
        },
      );

      final fetchStatus =
          await _getWatchlistStatusTvSeries.execute(event.data.id);

      emit(TvSeriesWatchlistStatusHasData(fetchStatus, message));
    });

    on<RemoveTvSeriesWatchlist>((event, emit) async {
      final result = await _removeWatchlistTvSeries.execute(event.data);
      String message = '';
      result.fold(
        (failure) {
          message = failure.message;
        },
        (successMessage) {
          message = successMessage;
        },
      );

      final fetchStatus =
          await _getWatchlistStatusTvSeries.execute(event.data.id);

      emit(TvSeriesWatchlistStatusHasData(fetchStatus, message));
    });

    on<ResetMessageWatchlistTvSeries>((event, emit) async {
      emit(TvSeriesWatchlistStatusHasData(event.isAddedWatchlist, ''));
    });
  }
}
