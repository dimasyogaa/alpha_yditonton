import 'dart:io';

void main() {
  String path = 'test/data/datasources/tv_local_data_source_test.dart';
  String content = File(path).readAsStringSync();
  content = content.replaceAll(
    'insertWatchlist(tTvTable)',
    'insertWatchlistTv(tTvTable)',
  );
  content = content.replaceAll(
    'removeWatchlist(tTvTable)',
    'removeWatchlistTv(tTvTable)',
  );
  content = content.replaceAll('tTvMap', 'testTvMap');
  content = content.replaceAll(
    'getWatchlistMovies',
    'getWatchlistTvs',
  ); // In case it wasn't replaced
  File(path).writeAsStringSync(content);
  print('Fixed tv_local_data_source_test.dart');
}
