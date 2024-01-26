import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.absolute.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  dir = dir.replaceAll("\\modules\\core", '');
  return File('$dir/modules/core/test/$name').readAsStringSync();
}
