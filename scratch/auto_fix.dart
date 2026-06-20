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

        // Fix ROUTE_NAME
        if (content.contains('ROUTE_NAME')) {
          content = content.replaceAll('ROUTE_NAME', 'routeName');
          modified = true;
        }

        // Fix library_private_types_in_public_api for createState
        final stateRegex = RegExp(
          r'_([A-Za-z0-9_]+)State\s+createState\(\)\s*=>\s*_\1State\(\);',
        );
        if (stateRegex.hasMatch(content)) {
          content = content.replaceAllMapped(stateRegex, (match) {
            final className = match.group(1);
            return 'State<$lassName>createState() => _${className}State();';
          });
          modified = true;
        }

        // Fix use_build_context_synchronously in Future.microtask
        final microtaskRegex = RegExp(
          r'Future\.microtask\(\s*\(\)\s*=>\s*(Provider\.of[^;]+)\);',
        );
        if (microtaskRegex.hasMatch(content)) {
          content = content.replaceAllMapped(microtaskRegex, (match) {
            return 'Future.microtask(() {\n      if (!mounted) return;\n      ${match.group(1)};\n    });';
          });
          modified = true;
        }

        if (modified) {
          entity.writeAsStringSync(content);
        }
      }
    }
  }

  processDir(dir);
  processDir(testDir);
  print('Done fixing ROUTE_NAME, createState, and simple microtasks.');
}
