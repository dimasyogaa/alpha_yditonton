import 'package:path/path.dart' as p;
import 'dart:io';

void main() {
  final Map<String, String> replacements = {
    'ABOUT_ROUTE': 'aboutRoute',
    'MOVIE_DETAIL_ROUTE': 'movieDetailRoute',
    'SEARCH_ROUTE': 'searchRoute',
    'POPULAR_MOVIES_ROUTE': 'popularMoviesRoute',
    'TOP_RATED_ROUTE': 'topRatedRoute',
    'HOME_TV_ROUTE': 'homeTvRoute',
    'ON_THE_AIR_ROUTE': 'onTheAirRoute',
    'POPULAR_TVS_ROUTE': 'popularTvsRoute',
    'TOP_RATED_TVS_ROUTE': 'topRatedTvsRoute',
    'TV_DETAIL_ROUTE': 'tvDetailRoute',
    'SEASON_DETAIL_ROUTE': 'seasonDetailRoute',
    'EPISODE_DETAIL_ROUTE': 'episodeDetailRoute',
    'SEARCH_TV_ROUTE': 'searchTvRoute',
    'WATCHLIST_ROUTE': 'watchlistRoute',
  };

  final dirs = ['lib', 'core', 'about', 'search', 'test'];
  for (var dir in dirs) {
    final dirInfo = Directory(dir);
    if (!dirInfo.existsSync()) continue;
    final files = dirInfo.listSync(recursive: true);
    for (var file in files) {
      if (file is File && file.path.endsWith('.dart')) {
        String content = file.readAsStringSync();
        bool changed = false;
        replacements.forEach((oldName, newName) {
          if (content.contains(oldName)) {
            // only replace full words
            content = content.replaceAll(RegExp(r'\b' + oldName + r'\b'), newName);
            changed = true;
          }
        });
        if (changed) {
          file.writeAsStringSync(content);
          print('Updated ${file.path}');
        }
      }
    }
  }
}
