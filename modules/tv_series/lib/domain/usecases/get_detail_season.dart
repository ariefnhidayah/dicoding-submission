import 'package:core/domain/entities/season_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetDetailSeason {
  final TvSeriesRepository repository;

  GetDetailSeason(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(
      int tvSeriesID, int seasonNumber) async {
    return await repository.getSeasonDetail(tvSeriesID, seasonNumber);
  }
}
