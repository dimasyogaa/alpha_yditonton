import 'dart:io';

void main() {
  final dir = Directory('lib');

  void processDir(Directory directory) {
    if (!directory.existsSync()) return;
    for (var entity in directory.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        String content = entity.readAsStringSync();
        bool changed = false;

        // placeholder: (context, url) =>
        final placeholderRegex =
            RegExp(r'placeholder:\s*\(\s*context\s*,\s*url\s*\)\s*=>');
        if (placeholderRegex.hasMatch(content)) {
          content = content.replaceAll(
              placeholderRegex, 'placeholder: (context, url) =>');
          // Actually, we want to replace with `(context, url)` to `(context, _)` but `url` might be unused.
        }

        // Let's replace specifically:
        final r1 = RegExp(r'\(\s*context\s*,\s*url\s*\)\s*=>');
        if (r1.hasMatch(content)) {
          content = content.replaceAll(r1, '(context, _) =>');
          changed = true;
        }

        final r2 = RegExp(r'\(\s*context\s*,\s*url\s*,\s*error\s*\)\s*=>');
        if (r2.hasMatch(content)) {
          content = content.replaceAll(r2, '(context, _, __) =>');
          changed = true;
        }

        final r3 = RegExp(r'\(\s*context\s*,\s*index\s*\)\s*=>');
        // only if index is unused, but it's hard to know. So I won't touch index unless I'm sure.

        if (changed) {
          entity.writeAsStringSync(content);
        }
      }
    }
  }

  processDir(dir);
  print('Done replacing wildcards.');
}
