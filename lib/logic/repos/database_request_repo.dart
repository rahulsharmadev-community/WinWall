import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '/logic/models/version.dart';
import '/logic/models/wallpaper.dart';
import '../models/category.dart';

const base =
    'https://raw.githubusercontent.com/rahulsharmadev-community/dummy-json-generater/master/database/photo_gallery/';

class DataBaseRequestRepo {
  Future<String> _get(String path) async {
    log('HTTP: $path');
    final Uri uri = Uri.parse('$base$path');
    try {
      var resp = await http.get(uri);
      return resp.body;
    } on http.ClientException catch (e) {
      throw e.message;
    }
  }

  Future<List<Version>> getVersions() async {
    log('getVersions');
    var versions = <Version>[];
    try {
      var split = (await _get('version.yaml')).split(RegExp(r'[:|\n]'));
      for (var i = 0; i < split.length - 1; i += 2) {
        var word = split[i].trim();
        versions.add(Version(
          title: word[0].toUpperCase() + word.substring(1),
          path: '$word.json',
          version: split[i + 1].trim(),
        ));
      }
      return versions;
    } catch (e) {
      rethrow;
    }
  }

  Future<Category> getWallpaperByCatalogVersion(Version version) async {
    try {
      var list = (jsonDecode(await _get(version.path)) as Map)
          .entries
          .map((e) => Wallpaper.fromMap({...Map.from(e.value), 'id': e.key}))
          .toList();
      return Category(
        list: list,
        title: version.title,
        version: version.version,
      );
    } catch (e) {
      rethrow;
    }
  }
}
