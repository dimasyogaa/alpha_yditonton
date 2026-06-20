import 'dart:io';

void main() {
  final outDir = Directory('tv/test/presentation/bloc');
  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }

  void createTest(String name, String typeName, String usecaseClass) {
    final snakeName = name;
    final camelName = typeName;
    
    File('${outDir.path}/${snakeName}_bloc_test.dart').writeAsStringSync('''
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_${snakeName}.dart';
import 'package:tv/presentation/bloc/${snakeName}_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '${snakeName}_bloc_test.mocks.dart';

@GenerateMocks([$usecaseClass])
void main() {
  late ${camelName}Bloc bloc;
  late Mock$usecaseClass mockUsecase;

  setUp(() {
    mockUsecase = Mock$usecaseClass();
    bloc = ${camelName}Bloc(mockUsecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, ${camelName}Empty());
  });

  final tTV = TV(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTVList = <TV>[tTV];

  blocTest<${camelName}Bloc, ${camelName}State>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(tTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(Fetch${camelName}()),
    expect: () => [
      ${camelName}Loading(),
      ${camelName}HasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );

  blocTest<${camelName}Bloc, ${camelName}State>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(Fetch${camelName}()),
    expect: () => [
      ${camelName}Loading(),
      ${camelName}Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );
}
''');
  }

  createTest('on_the_air_tvs', 'OnTheAirTVs', 'GetOnTheAirTVs');
  createTest('popular_tvs', 'PopularTVs', 'GetPopularTVs');
  createTest('top_rated_tvs', 'TopRatedTVs', 'GetTopRatedTVs');
  createTest('watchlist_tvs', 'WatchlistTVs', 'GetWatchlistTVs');
  createTest('tv_recommendations', 'TVRecommendations', 'GetTVRecommendations');

  print('TV BLoC tests generated');
}
