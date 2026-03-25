import 'package:musix_trans/data/services/local_data.dart';
import 'package:musix_trans/models/translation/translation.dart';
import 'package:musix_trans/utils/result.dart';

class TranslationRepository {
  TranslationRepository({required LocalData localData})
    : _localData = localData;

  final LocalData _localData;

  Result<Translation> getTransl(String trackId) {
    return _localData.getTransl(trackId);
  }
}
