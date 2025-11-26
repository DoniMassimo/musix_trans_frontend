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

class Line {
  final String line;
  final String trans;
  final String comment;

  Line(this.line, this.trans, this.comment);

  static Line buildLine(Map elem) {
    return Line(elem['words'], elem['trans'], elem['comment']);
  }
}

List<Line> getSongTrans(String trackId) {
  var box = Hive.box('lyrics');
  var tracksIds = box.keys;
  if (!tracksIds.contains(trackId)) {
    throw Exception("box does not contains trackId $trackId");
  }
  List trackData = box.get(trackId)?['lyric']?['lines'];
  List<Line> lines = trackData.map((elem) => Line.buildLine(elem)).toList();
  return lines;
}
