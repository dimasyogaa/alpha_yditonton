import 'dart:io';

void main() {
  String path = 'test/presentation/provider/movie_list_notifier_test.dart';
  String dest = 'test/presentation/provider/tv_list_notifier_test.dart';
  String content = File(path).readAsStringSync();
  content = content.replaceAll('Movie', 'Tv');
  content = content.replaceAll('movie', 'tv');
  content = content.replaceAll('NowPlaying', 'OnTheAir');
  content = content.replaceAll('now playing', 'on the air');
  content = content.replaceAll('now_playing', 'on_the_air');
  content = content.replaceAll('testTv', 'tTv');
  content = content.replaceAll('tTvList', 'tTvList');
  content = content.replaceAll('tTvList', 'tTvList');
  File(dest).writeAsStringSync(content);
  print('Generated tv_list_notifier_test.dart');
}
