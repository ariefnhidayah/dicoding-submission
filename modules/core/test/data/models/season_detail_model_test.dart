import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final seasonJson = json.decode(readJson('dummy_data/season_detail.json'));
  test('should be a subclass entity', () {
    final result = seasonDetailModel.toEntity();
    expect(result, seasonTvSeriesDetail);
  });

  test('should be convert model to json', () {
    final result = seasonDetailModel.toJson();
    expect(result, seasonJson);
  });
}
