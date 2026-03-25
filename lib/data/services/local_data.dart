import 'package:hive_ce/hive.dart';
import 'package:musix_trans/models/translation/translation.dart';
import 'package:musix_trans/utils/result.dart';

class LocalData {
  LocalData({required Box<Translation> box}) : _box = box;

  final Box<Translation> _box;

  Future<Result<String>> saveTransl(Translation trans) async {
    try {
      await _box.put(trans.track_id, trans);
      return Result.ok(trans.track_id);
    } catch (e) {
      return Result.error(Exception("Error: $e"));
    }
  }

  Result<Translation> getTransl(String trackId) {
    final transl = _box.get(trackId);
    if (transl == null) {
      return Result.error(Exception("Invalid trackId: $trackId"));
    }
    return Result.ok(transl);
  }

  Future<Result<List<String>>> getTranslIds() async {
    try {
      var rawKeys = _box.keys;
      List<String> keys = rawKeys.map((key) => key.toString()).toList();
      return Result.ok(keys);
    } catch (e) {
      return Result.error(Exception("Error: $e"));
    }
  }

  Result<List<Translation>> getAllTransl() {
    final allTransl = _box.values.toList();
    return Result.ok(allTransl);
  }
}
