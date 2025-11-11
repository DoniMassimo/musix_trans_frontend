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
