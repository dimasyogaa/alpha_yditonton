import 'dart:io';

void main() {
  String path = 'test/presentation/pages/movie_detail_page_test.dart';
  String content = File(path).readAsStringSync();

  String newTests = '''
  testWidgets('Page should display ProgressIndicator when state is Loading',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when state is Error',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.text('Error message');

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display DetailContent when state is Loaded',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.text('title'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
  });
''';

  content = content.replaceFirst(
    "    expect(find.text('Failed'), findsOneWidget);\n  });\n}",
    "    expect(find.text('Failed'), findsOneWidget);\n  });\n\n$newTests\n}",
  );
  File(path).writeAsStringSync(content);
  print('Added more tests to movie_detail_page_test.dart');
}
