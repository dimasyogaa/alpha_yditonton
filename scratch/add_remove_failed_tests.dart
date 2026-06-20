import 'dart:io';

void main() {
  // Movie Detail Notifier Test
  String moviePath =
      'test/presentation/provider/movie_detail_notifier_test.dart';
  String movieContent = File(moviePath).readAsStringSync();

  String movieTest = '''
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
''';

  movieContent = movieContent.replaceFirst(
    '  });\n\n  group(\'on Error\', () {',
    '  });\n\n$movieTest  });\n\n  group(\'on Error\', () {',
  );
  File(moviePath).writeAsStringSync(movieContent);

  // Tv Detail Notifier Test
  String tvPath = 'test/presentation/provider/tv_detail_notifier_test.dart';
  String tvContent = File(tvPath).readAsStringSync();

  String tvTest = '''
    test('should update watchlist message when remove watchlist failed', () async {
      // arrange
      when(mockRemoveWatchlist.execute(tTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(tTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
''';

  tvContent = tvContent.replaceFirst(
    '  });\n\n  group(\'on Error\', () {',
    '  });\n\n$tvTest  });\n\n  group(\'on Error\', () {',
  );
  File(tvPath).writeAsStringSync(tvContent);

  print('Added remove watchlist failed tests');
}
