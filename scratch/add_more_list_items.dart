import 'dart:io';

void main() {
  final files = [
    'test/presentation/pages/popular_movies_page_test.dart',
    'test/presentation/pages/watchlist_movies_page_test.dart',
    'test/presentation/pages/search_page_test.dart',
    'test/presentation/pages/search_tv_page_test.dart',
  ];

  for (final file in files) {
    if (File(file).existsSync()) {
      var content = File(file).readAsStringSync();

      content = content.replaceFirst(
        'home: body,',
        'home: Material(child: body),',
      );
      content = content.replaceFirst(
        'when(mockNotifier.movies).thenReturn(<Movie>[]);',
        "when(mockNotifier.movies).thenReturn([Movie(adult: false, backdropPath: 'backdropPath', genreIds: [1], id: 1, originalTitle: 'originalTitle', overview: 'overview', popularity: 1, posterPath: 'posterPath', releaseDate: 'releaseDate', title: 'title', video: false, voteAverage: 1, voteCount: 1)]);",
      );
      content = content.replaceFirst(
        'when(mockNotifier.watchlistMovies).thenReturn(<Movie>[]);',
        "when(mockNotifier.watchlistMovies).thenReturn([Movie(adult: false, backdropPath: 'backdropPath', genreIds: [1], id: 1, originalTitle: 'originalTitle', overview: 'overview', popularity: 1, posterPath: 'posterPath', releaseDate: 'releaseDate', title: 'title', video: false, voteAverage: 1, voteCount: 1)]);",
      );
      content = content.replaceFirst(
        'when(mockNotifier.searchResult).thenReturn(<Movie>[]);',
        "when(mockNotifier.searchResult).thenReturn([Movie(adult: false, backdropPath: 'backdropPath', genreIds: [1], id: 1, originalTitle: 'originalTitle', overview: 'overview', popularity: 1, posterPath: 'posterPath', releaseDate: 'releaseDate', title: 'title', video: false, voteAverage: 1, voteCount: 1)]);",
      );
      content = content.replaceFirst(
        'when(mockNotifier.searchResult).thenReturn(<Tv>[]);',
        "when(mockNotifier.searchResult).thenReturn([Tv(backdropPath: 'backdropPath', genreIds: [1], id: 1, originalName: 'originalName', overview: 'overview', popularity: 1, posterPath: 'posterPath', firstAirDate: 'firstAirDate', name: 'name', voteAverage: 1, voteCount: 1)]);",
      );

      File(file).writeAsStringSync(content);
      print('Updated \$file');
    }
  }
}
