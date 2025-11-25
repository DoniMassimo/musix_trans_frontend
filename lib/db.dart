import 'api.dart' as api;
import 'dart:convert';
import 'dart:io';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

/// Throws [Uri.https] exceptions
Future<void> updateDB() async {
  var box = Hive.box('lyrics');
  var a = box.keys;
  List<String> localKeys = a.map((key) => key.toString()).toList();
  List<String> remoteKeys = [];
  remoteKeys = await api.getTracksIds();
  List<String> missingKeys = remoteKeys
      .where((key) => !localKeys.contains(key))
      .toList();
  for (var missKey in missingKeys) {
    Map data = await api.getTrackData(missKey);
    box.put(missKey, data);
  }
}

class CatalogEntry {
  final String trackId;
  final String songName;
  final String author;

  CatalogEntry(this.trackId, this.songName, this.author);
}

List<CatalogEntry> getCatalog() {
  var box = Hive.box('lyrics');
  var tracksIds = box.keys;
  List<CatalogEntry> catalog = [];
  for (var trackId in tracksIds) {
    Map localData = box.get(trackId);
    String author =
        localData['lyric']?['spoty_api_data']?['artists']?[0]?['name'] ?? '';
    String songName = localData['lyric']?['spoty_api_data']?['name'] ?? '';
    var enrty = CatalogEntry(trackId, author, songName);
    catalog.add(enrty);
  }
  return catalog;
}

class HiveExporter {
  /// Esporta un solo box con nome [boxName]
  static Future<File> exportBox(String boxName) async {
    final box = Hive.box(boxName);

    final data = {"box": boxName, "values": box.toMap()};

    final jsonStr = const JsonEncoder.withIndent('  ').convert(data);
    final file = await _writeToFile(jsonStr, 'hive_export_$boxName.json');
    return file;
  }

  /// Scrive su file nella cartella documenti dell’app
  static Future<File> _writeToFile(String json, String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsString(json, flush: true);
    return file;
  }
}
