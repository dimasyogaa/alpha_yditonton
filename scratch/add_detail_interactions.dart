import 'dart:io';

void main() {
  String tvPath = 'test/presentation/pages/tv_detail_page_test.dart';
  String tvContent = File(tvPath).readAsStringSync();

  // Add Season import
  tvContent = tvContent.replaceFirst(
    "import 'package:ditonton/domain/entities/tv_detail.dart';",
    "import 'package:ditonton/domain/entities/tv_detail.dart';\nimport 'package:ditonton/domain/entities/season.dart';",
  );

  // Add Season to tTvDetail
  tvContent = tvContent.replaceFirst(
    "seasons: [],",
    "seasons: [Season(airDate: '2022', episodeCount: 1, id: 1, name: 'Season 1', overview: 'overview', posterPath: 'posterPath', seasonNumber: 1)],",
  );

  // Add new test
  String newTvTest = '''
  testWidgets('Page should display DetailContent and verify interactions',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(tTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[
      Tv(backdropPath: 'backdropPath', genreIds: [1], id: 1, originalName: 'originalName', overview: 'overview', popularity: 1, posterPath: 'posterPath', firstAirDate: 'firstAirDate', name: 'name', voteAverage: 1, voteCount: 1)
    ]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    // Verify Season List is rendered
    expect(find.text('Season 1'), findsOneWidget);
    
    // Verify Recommendation List is rendered
    expect(find.byType(Scrollable).last, findsOneWidget);
    
    // Tap on back button
    final backButton = find.byIcon(Icons.arrow_back);
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
  });
''';

  tvContent = tvContent.replaceFirst(
    "    expect(find.text('overview'), findsOneWidget);\n  });\n}",
    "    expect(find.text('overview'), findsOneWidget);\n  });\n\n$newTvTest\n}",
  );

  File(tvPath).writeAsStringSync(tvContent);
  print('Updated tv_detail_page_test.dart');

  String moviePath = 'test/presentation/pages/movie_detail_page_test.dart';
  String movieContent = File(moviePath).readAsStringSync();

  String newMovieTest = '''
  testWidgets('Page should display DetailContent and verify interactions',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[
      Movie(adult: false, backdropPath: 'backdropPath', genreIds: [1], id: 1, originalTitle: 'originalTitle', overview: 'overview', popularity: 1, posterPath: 'posterPath', releaseDate: 'releaseDate', title: 'title', video: false, voteAverage: 1, voteCount: 1)
    ]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    // Verify Recommendation List is rendered
    expect(find.byType(Scrollable).last, findsOneWidget);
    
    // Tap on back button
    final backButton = find.byIcon(Icons.arrow_back);
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
  });
''';

  movieContent = movieContent.replaceFirst(
    "    expect(find.text('overview'), findsOneWidget);\n  });\n}",
    "    expect(find.text('overview'), findsOneWidget);\n  });\n\n$newMovieTest\n}",
  );

  File(moviePath).writeAsStringSync(movieContent);
  print('Updated movie_detail_page_test.dart');
}
