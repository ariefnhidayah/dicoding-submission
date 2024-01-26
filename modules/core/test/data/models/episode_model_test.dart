import 'package:core/data/models/episode_model.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const episodeModel = EpisodeModel(
    airDate: 'airDate',
    episodeNumber: 1,
    episodeType: 'episodeType',
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  const episode = Episode(
    airDate: 'airDate',
    episodeNumber: 1,
    episodeType: 'episodeType',
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  const episodeJson = {
    "air_date": "airDate",
    "episode_number": 1,
    "episode_type": "episodeType",
    "id": 1,
    "name": "name",
    "overview": "overview",
    "production_code": "productionCode",
    "runtime": 1,
    "season_number": 1,
    "still_path": "stillPath",
    "vote_average": 1,
    "vote_count": 1,
    "show_id": 1
  };

  test('should be convert model to entity', () {
    final result = episodeModel.toEntity();
    expect(result, episode);
  });

  test('should be convert json to model', () {
    final result = EpisodeModel.fromJson(episodeJson);
    expect(result, episodeModel);
  });

  test('should be convert model to json', () {
    final result = episodeModel.toJson();
    expect(result, episodeJson);
  });
}
