import 'package:core/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  final String airDate;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;
  final double voteAverage;
  final List<Episode> episodes;

  const SeasonDetail({
    required this.airDate,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
    required this.episodes,
  });

  @override
  List<Object?> get props => [
        airDate,
        name,
        overview,
        id,
        posterPath,
        seasonNumber,
        voteAverage,
        episodes,
      ];
}
