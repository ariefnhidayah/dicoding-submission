import 'package:core/data/models/episode_model.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailModel extends Equatable {
  final String airDate;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;
  final double voteAverage;
  final List<EpisodeModel> episodes;

  const SeasonDetailModel({
    required this.airDate,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
    required this.episodes,
  });

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailModel(
        airDate: json['air_date'] ?? "",
        name: json["name"] ?? "",
        overview: json["overview"] ?? "",
        id: json["id"] ?? 1,
        posterPath: json["poster_path"] ?? "",
        seasonNumber: json["season_number"] ?? 1,
        voteAverage: json["vote_average"].toDouble(),
        episodes: List<EpisodeModel>.from(
            json['episodes'].map((x) => EpisodeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "name": name,
        "overview": overview,
        "id": id,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
        "episodes": List<dynamic>.from(episodes.map((e) => e.toJson()))
      };

  SeasonDetail toEntity() {
    return SeasonDetail(
      airDate: airDate,
      name: name,
      overview: overview,
      id: id,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      voteAverage: voteAverage,
      episodes: episodes.map((e) => e.toEntity()).toList(),
    );
  }

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
