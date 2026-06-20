import 'dart:io';

void main() {
  void replace(String path, Map<String, String> replacements) {
    String content = File(path).readAsStringSync();
    replacements.forEach((key, value) {
      content = content.replaceAll(key, value);
    });
    File(path).writeAsStringSync(content);
    print('Fixed $path');
  }

  replace('test/data/repositories/tv_repository_impl_test.dart', {
    'testTvDetail': 'tTvDetail',
    'testTvTable': 'tTvTable',
    'testWatchlistTv': 'tWatchlistTv',
    'testTv': 'tTv',
    'testTvModel': 'tTvModel',
    'adult: false,': '',
    'video: false,': '',
    'originalTitle': 'originalName',
    'title': 'name',
    'releaseDate': 'firstAirDate',
    'runtime: 120,': '',
    'isAddedToWatchlist': 'isAddedToWatchlistTv',
    'removeWatchlist': 'removeWatchlistTv',
    'saveWatchlist': 'saveWatchlistTv',
  });

  replace('test/data/datasources/tv_remote_data_source_test.dart', {
    'testTvDetail': 'tTvDetail',
    'testTvTable': 'tTvTable',
    'testWatchlistTv': 'tWatchlistTv',
    'testTv': 'tTv',
    'testTvModel': 'tTvModel',
    'adult: false,': '',
    'video: false,': '',
    'originalTitle': 'originalName',
    'title': 'name',
    'releaseDate': 'firstAirDate',
    'runtime: 120,': '',
  });

  replace('test/data/datasources/tv_local_data_source_test.dart', {
    'testTvDetail': 'tTvDetail',
    'testTvTable': 'tTvTable',
    'testWatchlistTv': 'tWatchlistTv',
    'testTv': 'tTv',
    'testTvModel': 'tTvModel',
    'adult: false,': '',
    'video: false,': '',
    'originalTitle': 'originalName',
    'title': 'name',
    'releaseDate': 'firstAirDate',
    'runtime: 120,': '',
  });
}
