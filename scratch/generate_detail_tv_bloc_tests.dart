import 'dart:io';

void main() {
  final outDir = Directory('tv/test/presentation/bloc');
  if (!outDir.existsSync()) {
    outDir.createSync(recursive: true);
  }

  // TV Detail
  File('${outDir.path}/tv_detail_bloc_test.dart').writeAsStringSync('''
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVDetail])
void main() {
  late TVDetailBloc bloc;
  late MockGetTVDetail mockUsecase;

  setUp(() {
    mockUsecase = MockGetTVDetail();
    bloc = TVDetailBloc(mockUsecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, TVDetailEmpty());
  });

  final tTVDetail = TVDetail(
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    seasons: [],
  );

  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute(1))
          .thenAnswer((_) async => Right(tTVDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTVDetail(1)),
    expect: () => [
      TVDetailLoading(),
      TVDetailHasData(tTVDetail),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(1));
    },
  );

  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTVDetail(1)),
    expect: () => [
      TVDetailLoading(),
      TVDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(1));
    },
  );
}
''');

  // Season Detail
  File('${outDir.path}/season_detail_bloc_test.dart').writeAsStringSync('''
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'package:tv/presentation/bloc/season_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'season_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeasonDetail])
void main() {
  late SeasonDetailBloc bloc;
  late MockGetTVSeasonDetail mockUsecase;

  setUp(() {
    mockUsecase = MockGetTVSeasonDetail();
    bloc = SeasonDetailBloc(mockUsecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, SeasonDetailEmpty());
  });

  final tSeasonDetail = SeasonDetail(
    id: '1',
    airDate: 'airDate',
    episodes: [],
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1,
  );

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute(1, 1))
          .thenAnswer((_) async => Right(tSeasonDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchSeasonDetail(1, 1)),
    expect: () => [
      SeasonDetailLoading(),
      SeasonDetailHasData(tSeasonDetail),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(1, 1));
    },
  );

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute(1, 1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchSeasonDetail(1, 1)),
    expect: () => [
      SeasonDetailLoading(),
      SeasonDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(1, 1));
    },
  );
}
''');

  // TV Watchlist
  File('${outDir.path}/tv_watchlist_bloc_test.dart').writeAsStringSync('''
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistStatusTV, SaveWatchlistTV, RemoveWatchlistTV])
void main() {
  late TVWatchlistBloc bloc;
  late MockGetWatchlistStatusTV mockGetWatchlistStatusTV;
  late MockSaveWatchlistTV mockSaveWatchlistTV;
  late MockRemoveWatchlistTV mockRemoveWatchlistTV;

  setUp(() {
    mockGetWatchlistStatusTV = MockGetWatchlistStatusTV();
    mockSaveWatchlistTV = MockSaveWatchlistTV();
    mockRemoveWatchlistTV = MockRemoveWatchlistTV();
    bloc = TVWatchlistBloc(
      mockGetWatchlistStatusTV,
      mockSaveWatchlistTV,
      mockRemoveWatchlistTV,
    );
  });

  test('initial state should be status false', () {
    expect(bloc.state, TVWatchlistStatus(false));
  });

  final tTVDetail = TVDetail(
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    seasons: [],
  );

  blocTest<TVWatchlistBloc, TVWatchlistState>(
    'Should emit [Status] when load status is called',
    build: () {
      when(mockGetWatchlistStatusTV.execute(1)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(1)),
    expect: () => [
      TVWatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistStatusTV.execute(1));
    },
  );

  blocTest<TVWatchlistBloc, TVWatchlistState>(
    'Should emit [Message, Status] when add watchlist is successful',
    build: () {
      when(mockSaveWatchlistTV.execute(tTVDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatusTV.execute(1)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(AddTVToWatchlist(tTVDetail)),
    expect: () => [
      TVWatchlistMessage('Added to Watchlist'),
      TVWatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTV.execute(tTVDetail));
      verify(mockGetWatchlistStatusTV.execute(1));
    },
  );

  blocTest<TVWatchlistBloc, TVWatchlistState>(
    'Should emit [Error, Status] when add watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlistTV.execute(tTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      when(mockGetWatchlistStatusTV.execute(1)).thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(AddTVToWatchlist(tTVDetail)),
    expect: () => [
      TVWatchlistError('Database Failure'),
      TVWatchlistStatus(false),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTV.execute(tTVDetail));
      verify(mockGetWatchlistStatusTV.execute(1));
    },
  );

  blocTest<TVWatchlistBloc, TVWatchlistState>(
    'Should emit [Message, Status] when remove watchlist is successful',
    build: () {
      when(mockRemoveWatchlistTV.execute(tTVDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      when(mockGetWatchlistStatusTV.execute(1)).thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveTVFromWatchlist(tTVDetail)),
    expect: () => [
      TVWatchlistMessage('Removed from Watchlist'),
      TVWatchlistStatus(false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTV.execute(tTVDetail));
      verify(mockGetWatchlistStatusTV.execute(1));
    },
  );
}
''');

  print('TV Detail BLoC tests generated');
}
