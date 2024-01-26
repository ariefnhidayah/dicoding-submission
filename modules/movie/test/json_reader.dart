import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  dir = dir.replaceAll("\\modules\\movie", '');
  return File('$dir/modules/movie/test/$name').readAsStringSync();
}
