part of 'season_detail_bloc.dart';

class SeasonDetailEvent extends Equatable {
  const SeasonDetailEvent();

  @override
  List<Object> get props => [];
}

final class FetchSeasonDetail extends SeasonDetailEvent {
  final int tvSeriesID;
  final int seasonNumber;

  const FetchSeasonDetail(this.tvSeriesID, this.seasonNumber);

  @override
  List<Object> get props => [
        tvSeriesID,
        seasonNumber,
      ];
}
