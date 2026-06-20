import 'dart:io';

void main() {
  final files = [
    'test/presentation/pages/top_rated_tvs_page_test.dart',
    'test/presentation/pages/top_rated_movies_page_test.dart',
    'test/presentation/pages/popular_tvs_page_test.dart',
    'test/presentation/pages/watchlist_tvs_page_test.dart',
  ];

  for (final file in files) {
    if (File(file).existsSync()) {
      var content = File(file).readAsStringSync();

      content = content.replaceFirst(
        'home: body,',
        'home: Material(child: body),',
      );

      File(file).writeAsStringSync(content);
      print('Updated \$file');
    }
  }
}
