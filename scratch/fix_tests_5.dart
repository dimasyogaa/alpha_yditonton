import 'dart:io';

void main() {
  String path = 'test/data/repositories/tv_repository_impl_test.dart';
  String content = File(path).readAsStringSync();
  content = content.replaceAll("status: 'Status',", "");
  content = content.replaceAll("tagline: 'Tagline',", "");
  content = content.replaceAll(
    "voteAverage: 1.0,",
    "voteAverage: 1.0, voteCount: 1, seasons: [],",
  );
  File(path).writeAsStringSync(content);
  print('Fixed repo test status and tagline');
}
