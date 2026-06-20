import 'dart:io';

void main() {
  String path = 'test/presentation/pages/tv_detail_page_test.dart';
  String content = File(path).readAsStringSync();

  String newTests = '''
  testWidgets('Page should display ProgressIndicator when state is Loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when state is Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.text('Error message');

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display DetailContent when state is Loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(tTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.text('name'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
  });
''';

  content = content.replaceFirst('}', '$newTests}'
  File(path).writeAsStringSync(content);
  print('Added more tests to tv_detail_page_test.dart');
}
