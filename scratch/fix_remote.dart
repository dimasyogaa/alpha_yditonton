import 'dart:io';

void main() {
  String path = 'test/data/datasources/tv_remote_data_source_test.dart';
  String content = File(path).readAsStringSync();
  content = content.replaceAll("'\$BASE_URL/movie/", "'\$BASE_URL/tv/");
  content = content.replaceAll("'/movie/", "'/tv/");
  content = content.replaceAll('/movie/', '/tv/');
  content = content.replaceAll("search/movie?", "search/tv?");
  File(path).writeAsStringSync(content);
  print('Fixed remote test');
}
