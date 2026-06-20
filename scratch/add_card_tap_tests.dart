import 'dart:io';

void main() {
  var path1 = 'test/presentation/widgets/movie_card_list_test.dart';
  var content1 = File(path1).readAsStringSync();
  var test1 = '''
  testWidgets('MovieCard should be able to be tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: MovieCard(testMovie)),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => Container());
      },
    ));
    await tester.tap(find.byType(InkWell));
  });
''';
  content1 = content1.replaceFirst('}\n', '\$test1}\n');
  File(path1).writeAsStringSync(content1);

  var path2 = 'test/presentation/widgets/tv_card_list_test.dart';
  var content2 = File(path2).readAsStringSync();
  var test2 = '''
  testWidgets('TvCard should be able to be tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: TvCard(testTv)),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => Container());
      },
    ));
    await tester.tap(find.byType(InkWell));
  });
''';
  content2 = content2.replaceFirst('}\n', '\$test2}\n');
  File(path2).writeAsStringSync(content2);
}
