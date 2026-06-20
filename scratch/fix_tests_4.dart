import 'dart:io';

void main() {
  String path = 'test/data/repositories/tv_repository_impl_test.dart';
  String content = File(path).readAsStringSync();
  content = content.replaceAll("popularity: 1,", "");
  File(path).writeAsStringSync(content);
  print('Fixed repo test popularity');
}
