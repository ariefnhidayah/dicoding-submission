import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String overview;
  final String posterPath;

  TvSeriesTable({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeries) => TvSeriesTable(
        id: tvSeries.id,
        name: tvSeries.name,
        overview: tvSeries.overview,
        posterPath: tvSeries.posterPath,
      );

  factory TvSeriesTable.fromMap(Map<String, dynamic> json) => TvSeriesTable(
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        posterPath: json['posterPath'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "posterPath": posterPath,
        "overview": overview,
      };

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name ?? "",
      );

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
      ];
}
