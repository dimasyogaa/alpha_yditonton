import 'dart:io';

void main() {
  String tvPath = 'test/presentation/pages/tv_detail_page_test.dart';
  String tvContent = File(tvPath).readAsStringSync();

  String tvTapTest = '''
  testWidgets('Page should be able to tap recommendation card',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(tTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[
      Tv(backdropPath: 'backdropPath', genreIds: [1], id: 1, originalName: 'originalName', overview: 'overview', popularity: 1, posterPath: 'posterPath', firstAirDate: 'firstAirDate', name: 'name', voteAverage: 1, voteCount: 1)
    ]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    final recommendationCard = find.byType(InkWell).last;
    await tester.tap(recommendationCard);
  });
''';

  tvContent = tvContent.replaceFirst('}\n', '$tvTapTest\n}\n');
  File(tvPath).writeAsStringSync(tvContent);
  print('Updated tv_detail_page_test.dart');

  String moviePath = 'test/presentation/pages/movie_detail_page_test.dart';
  String movieContent = File(moviePath).readAsStringSync();

  String movieTapTest = '''
  testWidgets('Page should be able to tap recommendation card',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[
      Movie(adult: false, backdropPath: 'backdropPath', genreIds: [1], id: 1, originalTitle: 'originalTitle', overview: 'overview', popularity: 1, posterPath: 'posterPath', releaseDate: 'releaseDate', title: 'title', video: false, voteAverage: 1, voteCount: 1)
    ]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    final recommendationCard = find.byType(InkWell).last;
    await tester.tap(recommendationCard);
  });
''';

  movieContent = movieContent.replaceFirst('}\n', '$movieTapTest\n}\n');
  File(moviePath).writeAsStringSync(movieContent);
  print('Updated movie_detail_page_test.dart');
}
