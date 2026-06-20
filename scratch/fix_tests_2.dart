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
    'budget: 100,': '',
    'revenue: 12000,': '',
    'homepage: "https://google.com",': '',
    'imdbId: "imdb1",': '',
    'status: "Status",': '',
    'tagline: "Tagline",': '',
    'removeWatchlistTv(tTvTable)': 'removeWatchlist(tTvTable)',
    'insertWatchlistTv(tTvTable)': 'insertWatchlist(tTvTable)',
    'getWatchlistTvsTv()': 'getWatchlistTvs()',
  });
}
