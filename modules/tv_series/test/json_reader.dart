import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  dir = dir.replaceAll("\\modules\\tv_series", '');
  return File('$dir/modules/tv_series/test/$name').readAsStringSync();
}
