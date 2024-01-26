import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const seasonModel = SeasonModel(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1,
  );

  const season = Season(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1,
  );

  const seasonJson = {
    "air_date": "airDate",
    "episode_count": 1,
    "id": 1,
    "name": "name",
    "overview": "overview",
    "poster_path": "posterPath",
    "season_number": 1,
    "vote_average": 1
  };

  test('should be convert model to entity', () {
    final result = seasonModel.toEntity();
    expect(result, season);
  });

  test('should be convert model to json', () {
    final result = seasonModel.toJson();
    expect(result, seasonJson);
  });

  test('should be convert json to model', () {
    final result = SeasonModel.fromJson(seasonJson);
    expect(result, seasonModel);
  });
}
