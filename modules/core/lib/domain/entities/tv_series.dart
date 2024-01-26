// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String overview;
  double? popularity;
  String posterPath;
  String? firstAirDate;
  String name;
  double? voteAverage;
  int? voteCount;

  TvSeries({
    this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.firstAirDate,
    required this.name,
    this.voteAverage,
    this.voteCount,
  });

  TvSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
      ];
}
