import 'dart:io';

void main() {
  final outDir = Directory('tv/test/presentation/pages');

  // popular_tvs_page_test.dart
  File('${outDir.path}/popular_tvs_page_test.dart').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/popular_tvs_bloc.dart';
import 'package:tv/presentation/pages/popular_tvs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularTVsBloc extends MockBloc<PopularTVsEvent, PopularTVsState> implements PopularTVsBloc {}

class FakePopularTVsEvent extends Fake implements PopularTVsEvent {}
class FakePopularTVsState extends Fake implements PopularTVsState {}

void main() {
  late MockPopularTVsBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularTVsEvent());
    registerFallbackValue(FakePopularTVsState());
  });

  setUp(() {
    mockBloc = MockPopularTVsBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVsBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: Material(child: body)),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(PopularTVsLoading());
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(makeTestableWidget(PopularTVsPage()));
    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(PopularTVsHasData([
      TV(
        backdropPath: 'backdropPath',
        genreIds: [1],
        id: 1,
        originalName: 'originalName',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        firstAirDate: 'firstAirDate',
        name: 'name',
        voteAverage: 1,
        voteCount: 1,
      ),
    ]));
    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(makeTestableWidget(PopularTVsPage()));
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(PopularTVsError('Error message'));
    final textFinder = find.byKey(Key('error_message'));
    await tester.pumpWidget(makeTestableWidget(PopularTVsPage()));
    expect(textFinder, findsOneWidget);
  });
}
''');

  // top_rated_tvs_page_test.dart
  File('${outDir.path}/top_rated_tvs_page_test.dart').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopRatedTVsBloc extends MockBloc<TopRatedTVsEvent, TopRatedTVsState> implements TopRatedTVsBloc {}

class FakeTopRatedTVsEvent extends Fake implements TopRatedTVsEvent {}
class FakeTopRatedTVsState extends Fake implements TopRatedTVsState {}

void main() {
  late MockTopRatedTVsBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTVsEvent());
    registerFallbackValue(FakeTopRatedTVsState());
  });

  setUp(() {
    mockBloc = MockTopRatedTVsBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVsBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: Material(child: body)),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedTVsLoading());
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(makeTestableWidget(TopRatedTVsPage()));
    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedTVsHasData([
      TV(
        backdropPath: 'backdropPath',
        genreIds: [1],
        id: 1,
        originalName: 'originalName',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        firstAirDate: 'firstAirDate',
        name: 'name',
        voteAverage: 1,
        voteCount: 1,
      ),
    ]));
    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(makeTestableWidget(TopRatedTVsPage()));
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedTVsError('Error message'));
    final textFinder = find.byKey(Key('error_message'));
    await tester.pumpWidget(makeTestableWidget(TopRatedTVsPage()));
    expect(textFinder, findsOneWidget);
  });
}
''');

  // watchlist_tvs_page_test.dart
  File('${outDir.path}/watchlist_tvs_page_test.dart').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/watchlist_tvs_bloc.dart';
import 'package:tv/presentation/pages/watchlist_tvs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistTVsBloc extends MockBloc<WatchlistTVsEvent, WatchlistTVsState> implements WatchlistTVsBloc {}

class FakeWatchlistTVsEvent extends Fake implements WatchlistTVsEvent {}
class FakeWatchlistTVsState extends Fake implements WatchlistTVsState {}

void main() {
  late MockWatchlistTVsBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistTVsEvent());
    registerFallbackValue(FakeWatchlistTVsState());
  });

  setUp(() {
    mockBloc = MockWatchlistTVsBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTVsBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: Material(child: body)),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(WatchlistTVsLoading());
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(makeTestableWidget(WatchlistTVsPage()));
    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(WatchlistTVsHasData([
      TV(
        backdropPath: 'backdropPath',
        genreIds: [1],
        id: 1,
        originalName: 'originalName',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        firstAirDate: 'firstAirDate',
        name: 'name',
        voteAverage: 1,
        voteCount: 1,
      ),
    ]));
    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(makeTestableWidget(WatchlistTVsPage()));
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(WatchlistTVsError('Error message'));
    final textFinder = find.byKey(Key('error_message'));
    await tester.pumpWidget(makeTestableWidget(WatchlistTVsPage()));
    expect(textFinder, findsOneWidget);
  });
}
''');

  // tv_detail_page_test.dart
  File('${outDir.path}/tv_detail_page_test.dart').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendations_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTVDetailBloc extends MockBloc<TVDetailEvent, TVDetailState> implements TVDetailBloc {}
class MockTVRecommendationsBloc extends MockBloc<TVRecommendationsEvent, TVRecommendationsState> implements TVRecommendationsBloc {}
class MockTVWatchlistBloc extends MockBloc<TVWatchlistEvent, TVWatchlistState> implements TVWatchlistBloc {}

class FakeTVDetailEvent extends Fake implements TVDetailEvent {}
class FakeTVDetailState extends Fake implements TVDetailState {}
class FakeTVRecommendationsEvent extends Fake implements TVRecommendationsEvent {}
class FakeTVRecommendationsState extends Fake implements TVRecommendationsState {}
class FakeTVWatchlistEvent extends Fake implements TVWatchlistEvent {}
class FakeTVWatchlistState extends Fake implements TVWatchlistState {}

void main() {
  late MockTVDetailBloc mockTVDetailBloc;
  late MockTVRecommendationsBloc mockTVRecommendationsBloc;
  late MockTVWatchlistBloc mockTVWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(FakeTVDetailEvent());
    registerFallbackValue(FakeTVDetailState());
    registerFallbackValue(FakeTVRecommendationsEvent());
    registerFallbackValue(FakeTVRecommendationsState());
    registerFallbackValue(FakeTVWatchlistEvent());
    registerFallbackValue(FakeTVWatchlistState());
  });

  setUp(() {
    mockTVDetailBloc = MockTVDetailBloc();
    mockTVRecommendationsBloc = MockTVRecommendationsBloc();
    mockTVWatchlistBloc = MockTVWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVDetailBloc>.value(value: mockTVDetailBloc),
        BlocProvider<TVRecommendationsBloc>.value(value: mockTVRecommendationsBloc),
        BlocProvider<TVWatchlistBloc>.value(value: mockTVWatchlistBloc),
      ],
      child: MaterialApp(home: body),
    );
  }

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

  testWidgets('Watchlist button should display add icon when TV not added to watchlist', (WidgetTester tester) async {
    when(() => mockTVDetailBloc.state).thenReturn(TVDetailHasData(tTVDetail));
    when(() => mockTVRecommendationsBloc.state).thenReturn(TVRecommendationsHasData(<TV>[]));
    when(() => mockTVWatchlistBloc.state).thenReturn(TVWatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should display check icon when TV is added to watchlist', (WidgetTester tester) async {
    when(() => mockTVDetailBloc.state).thenReturn(TVDetailHasData(tTVDetail));
    when(() => mockTVRecommendationsBloc.state).thenReturn(TVRecommendationsHasData(<TV>[]));
    when(() => mockTVWatchlistBloc.state).thenReturn(TVWatchlistStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
''');

  print('TV UI tests generated');
}
