import 'api.dart' as api;
import 'package:hive_flutter/hive_flutter.dart';

void updateDB() async {
  var box = Hive.box('lyrics');
  var a = box.keys;
  List<String> localKeys = a.map((key) => key.toString()).toList();
  List<String> remoteKeys = await api.getTracksIds();
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
