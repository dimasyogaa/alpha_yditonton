import 'dart:io';

void main() {
  final dir = Directory('test');

  void processDir(Directory directory) {
    if (!directory.existsSync()) return;
    for (final entity in directory.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        var content = entity.readAsStringSync();

        final pattern = r'"""[\s\S]*?"""|'
            r"'''[\s\S]*?'''|"
            r'"([^"\\]|\\.)*"|'
            r"'([^'\\]|\\.)*'|"
            r'/\*[\s\S]*?\*/|'
            r'//[^\n]*';

        final regex = RegExp(pattern);

        content = content.replaceAllMapped(regex, (match) {
          final str = match.group(0)!;
          if (str.startsWith('//') || str.startsWith('/*')) {
            final lower = str.toLowerCase();
            if (lower.contains('arrange') ||
                lower.contains('act') ||
                lower.contains('assert')) {
              return str;
            }
            return '';
          }
          return str;
        });

        // Optional: clean up double empty lines that might result from removed comments
        content = content.replaceAll(RegExp(r'\n[ \t]*\n[ \t]*\n'), '\n\n');

        entity.writeAsStringSync(content);
      }
    }
  }

  processDir(dir);
  print('Done cleaning comments in test folder.');
}
