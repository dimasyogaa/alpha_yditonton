import 'dart:io';

void main() {
  var path1 = 'test/presentation/widgets/movie_card_list_test.dart';
  var c1 = File(path1).readAsStringSync();
  c1 = c1.replaceAll('\$test1}', '  }');
  var test1 = '''
  testWidgets('MovieCard should be able to be tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: MovieCard(tMovie)),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => Container());
      },
    ));
    await tester.tap(find.byType(InkWell));
  });
''';
  c1 = c1.replaceFirst('}\n', '\$test1}\n');
  File(path1).writeAsStringSync(c1);

  var path2 = 'test/presentation/widgets/tv_card_list_test.dart';
  var c2 = File(path2).readAsStringSync();
  c2 = c2.replaceAll('\$test2}', '  }');
  var test2 = '''
  testWidgets('TvCard should be able to be tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: TvCard(tTv)),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => Container());
      },
    ));
    await tester.tap(find.byType(InkWell));
  });
''';
  c2 = c2.replaceFirst('}\n', '\$test2}\n');
  File(path2).writeAsStringSync(c2);

  var path3 = 'test/presentation/provider/movie_detail_notifier_test.dart';
  var c3 = File(path3).readAsStringSync();
  c3 = c3.replaceFirst(
    '''
    test('should update watchlist message when remove watchlist failed', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testMovieDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {''',
    '''
    test('should update watchlist message when remove watchlist failed', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testMovieDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {''',
  );
  // Wait, the previous replacement inserted `});\n\n$movieTest  });\n\n  group('on Error', () {`
  // so it looks like:
  //   test('should update ...
  //   });
  //   });
  //
  //   group('on Error', () {
  // We need to fix syntax errors. It's better to just regex replace the broken part.
}
