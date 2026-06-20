import 'dart:io';

void main() {
  final dir = Directory('lib');
  final testDir = Directory('test');

  void processDir(Directory directory) {
    if (!directory.existsSync()) return;
    for (var entity in directory.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        String content = entity.readAsStringSync();
        bool changed = false;

        // Rename k constants
        final kConstants = {
          'kColorScheme': 'colorScheme',
          'kTextTheme': 'textTheme',
          'kHeading5': 'heading5',
          'kHeading6': 'heading6',
          'kSubtitle': 'subtitle',
          'kBodyText': 'bodyText',
          'kRichBlack': 'richBlack',
          'kMikadoYellow': 'mikadoYellow',
          'kDavysGrey': 'davysGrey',
          'kDrawerTheme': 'drawerTheme'
        };

        for (var entry in kConstants.entries) {
          if (content.contains(entry.key)) {
            content = content.replaceAll(entry.key, entry.value);
            changed = true;
          }
        }

        // Rename Tv to TV in identifiers.
        final tvRegex1 = RegExp(r'\bTv\b');
        if (tvRegex1.hasMatch(content)) {
          content = content.replaceAll(tvRegex1, 'TV');
          changed = true;
        }

        final tvRegex2 = RegExp(r'\bTv([A-Z])');
        if (tvRegex2.hasMatch(content)) {
          content = content.replaceAllMapped(
              tvRegex2, (match) => 'TV${match.group(1)}');
          changed = true;
        }

        final tvRegex3 = RegExp(r'([a-z])Tv\b');
        if (tvRegex3.hasMatch(content)) {
          content = content.replaceAllMapped(
              tvRegex3, (match) => '${match.group(1)}TV');
          changed = true;
        }

        final tvRegex4 = RegExp(r'([a-z])Tv([A-Z])');
        if (tvRegex4.hasMatch(content)) {
          content = content.replaceAllMapped(
              tvRegex4, (match) => '${match.group(1)}TV${match.group(2)}');
          changed = true;
        }

        final tvsRegex = RegExp(r'\bTvs\b');
        if (tvsRegex.hasMatch(content)) {
          content = content.replaceAll(tvsRegex, 'TVs');
          changed = true;
        }
        final tvsRegex2 = RegExp(r'\bTvs([A-Z])');
        if (tvsRegex2.hasMatch(content)) {
          content = content.replaceAllMapped(
              tvsRegex2, (match) => 'TVs${match.group(1)}');
          changed = true;
        }
        final tvsRegex3 = RegExp(r'([a-z])Tvs\b');
        if (tvsRegex3.hasMatch(content)) {
          content = content.replaceAllMapped(
              tvsRegex3, (match) => '${match.group(1)}TVs');
          changed = true;
        }
        final tvsRegex4 = RegExp(r'([a-z])Tvs([A-Z])');
        if (tvsRegex4.hasMatch(content)) {
          content = content.replaceAllMapped(
              tvsRegex4, (match) => '${match.group(1)}TVs${match.group(2)}');
          changed = true;
        }

        if (changed) {
          entity.writeAsStringSync(content);
        }
      }
    }
  }

  processDir(dir);
  processDir(testDir);
  print('Done renaming.');
}
