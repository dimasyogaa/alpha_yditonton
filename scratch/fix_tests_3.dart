import 'dart:io';

void main() {
  String path = 'test/data/datasources/tv_local_data_source_test.dart';
  String content = File(path).readAsStringSync();
  content = content.replaceAll(
    'dataSource.insertWatchlistTv',
    'dataSource.insertWatchlist',
  );
  content = content.replaceAll(
    'dataSource.removeWatchlistTv',
    'dataSource.removeWatchlist',
  );
  File(path).writeAsStringSync(content);
  print('Fixed local data source test');

  String path2 = 'test/data/repositories/tv_repository_impl_test.dart';
  String content2 = File(path2).readAsStringSync();
  content2 = content2.replaceAll("originalLanguage: 'en',", "");
  File(path2).writeAsStringSync(content2);
  print('Fixed repo test');
}
