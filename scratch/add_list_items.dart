import 'dart:io';

void main() {
  final files = [
    'test/presentation/pages/top_rated_tvs_page_test.dart',
    'test/presentation/pages/top_rated_movies_page_test.dart',
    'test/presentation/pages/popular_tvs_page_test.dart',
    'test/presentation/pages/watchlist_tvs_page_test.dart',
  ];

  for (final file in files) {
    if (File(file).existsSync()) {
      var content = File(file).readAsStringSync();

      // We want to replace `<Tv>[]` or `<Movie>[]` with a list containing one dummy item.
      if (file.contains('movies_page')) {
        content = content.replaceFirst(
          'when(mockNotifier.movies).thenReturn(<Movie>[]);',
          "when(mockNotifier.movies).thenReturn([Movie(adult: false, backdropPath: 'backdropPath', genreIds: [1], id: 1, originalTitle: 'originalTitle', overview: 'overview', popularity: 1, posterPath: 'posterPath', releaseDate: 'releaseDate', title: 'title', video: false, voteAverage: 1, voteCount: 1)]);",
        );
      } else {
        content = content.replaceFirst(
          'when(mockNotifier.tvs).thenReturn(<Tv>[]);',
          "when(mockNotifier.tvs).thenReturn([Tv(backdropPath: 'backdropPath', genreIds: [1], id: 1, originalName: 'originalName', overview: 'overview', popularity: 1, posterPath: 'posterPath', firstAirDate: 'firstAirDate', name: 'name', voteAverage: 1, voteCount: 1)]);",
        );
        content = content.replaceFirst(
          'when(mockNotifier.watchlistTvs).thenReturn(<Tv>[]);',
          "when(mockNotifier.watchlistTvs).thenReturn([Tv(backdropPath: 'backdropPath', genreIds: [1], id: 1, originalName: 'originalName', overview: 'overview', popularity: 1, posterPath: 'posterPath', firstAirDate: 'firstAirDate', name: 'name', voteAverage: 1, voteCount: 1)]);",
        );
      }

      File(file).writeAsStringSync(content);
      print('Updated \$file');
    }
  }
}
