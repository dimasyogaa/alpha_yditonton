import 'dart:io';

void main() {
  void copyAndReplace(String sourcePath, String destPath) {
    String content = File(sourcePath).readAsStringSync();

    // Replace logic for movie to tv
    content = content.replaceAll('Movie', 'Tv');
    content = content.replaceAll('movie', 'tv');
    content = content.replaceAll('NowPlaying', 'OnTheAir');
    content = content.replaceAll('now playing', 'on the air');
    content = content.replaceAll('now_playing', 'on_the_air');
    content = content.replaceAll('On The Air Movies', 'On The Air Tvs');

    // Specifically for repository
    content = content.replaceAll('testTv', 'testTv'); // from testMovie

    File(destPath).writeAsStringSync(content);
    print('Generated $destPath');
  }

  copyAndReplace(
    'test/data/repositories/movie_repository_impl_test.dart',
    'test/data/repositories/tv_repository_impl_test.dart',
  );
  copyAndReplace(
    'test/data/datasources/movie_remote_data_source_test.dart',
    'test/data/datasources/tv_remote_data_source_test.dart',
  );
  copyAndReplace(
    'test/data/datasources/movie_local_data_source_test.dart',
    'test/data/datasources/tv_local_data_source_test.dart',
  );
}
