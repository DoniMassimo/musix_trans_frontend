import 'api.dart' as api;
import 'dart:convert';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// Throws [Uri.https] exceptions
void updateDB() async {
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

void getCatalog() {
  var box = Hive.box('lyrics');
  var tracksIds = box.keys;
  List<Map> catalog = [];
  for (var trackId in tracksIds) {
    Map localData = box.get(trackId);
    String author =
        localData['lyric']['spoty_api_data']['artists']['0']['name'];
    String songName = localData['lyric']['spoty_api_data']['name'];
  }
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
