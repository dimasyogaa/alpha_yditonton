import 'dart:io';

void main() {
  String path = 'test/presentation/provider/tv_list_notifier_test.dart';
  String content = File(path).readAsStringSync();
  content = content.replaceAll(
    "originalTitle: 'originalTitle',",
    "originalName: 'originalName',",
  );
  content = content.replaceAll("title: 'title',", "name: 'name',");
  content = content.replaceAll(
    "releaseDate: 'releaseDate',",
    "firstAirDate: 'firstAirDate',",
  );
  File(path).writeAsStringSync(content);
  print('Fixed tv properties in list notifier test');
}
