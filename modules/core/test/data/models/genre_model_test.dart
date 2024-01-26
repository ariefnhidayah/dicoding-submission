import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final genreModel = GenreModel(id: 1, name: 'name');
  const genre = Genre(id: 1, name: 'name');
  final genreJson = {
    'id': 1,
    'name': 'name',
  };

  test('should be convert genre model to entity', () {
    final result = genreModel.toEntity();
    expect(result, genre);
  });

  test('should be convert genre json to genre model', () {
    final result = GenreModel.fromJson(genreJson);
    expect(result, genreModel);
  });

  test('should be convert genre model to json', () {
    final result = genreModel.toJson();
    expect(result, genreJson);
  });
}
