import 'dart:io';

void main() {
  final dir = Directory('lib');
  final testDir = Directory('test');

  void processDir(Directory directory) {
    if (!directory.existsSync()) return;
    for (final entity in directory.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        var content = entity.readAsStringSync();
        var modified = false;

        final replacements = {
          'API_KEY': 'apiKey',
          'BASE_URL': 'baseUrl',
          'BASE_IMAGE_URL': 'baseImageUrl',
          'RequestState.Empty': 'RequestState.empty',
          'RequestState.Loading': 'RequestState.loading',
          'RequestState.Loaded': 'RequestState.loaded',
          'RequestState.Error': 'RequestState.error',
        };

        if (content.contains(
          'enum RequestState { Empty, Loading, Loaded, Error }',
        )) {
          content = content.replaceAll(
            'enum RequestState { Empty, Loading, Loaded, Error }',
            'enum RequestState { empty, loading, loaded, error }',
          );
          modified = true;
        }

        for (final entry in replacements.entries) {
          if (content.contains(entry.key)) {
            content = content.replaceAll(entry.key, entry.value);
            modified = true;
          }
        }

        if (modified) {
          entity.writeAsStringSync(content);
        }
      }
    }
  }

  processDir(dir);
  processDir(testDir);
  print('Done fixing consts.');
}
