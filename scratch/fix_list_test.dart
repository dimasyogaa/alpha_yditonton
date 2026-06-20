import 'dart:io';

void main() {
  String path = 'test/presentation/provider/tv_list_notifier_test.dart';
  String content = File(path).readAsStringSync();
  content = content.replaceAll('nowPlayingState', 'onTheAirState');
  content = content.replaceAll('nowPlayingTvs', 'onTheAirTvs');
  content = content.replaceAll('adult: false,', '');
  content = content.replaceAll('video: false,', '');
  File(path).writeAsStringSync(content);
  print('Fixed tv list notifier test');
}
