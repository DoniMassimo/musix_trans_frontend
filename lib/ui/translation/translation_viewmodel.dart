import 'package:musix_trans/utils/result.dart';
import 'package:musix_trans/models/translation/translation.dart';
import 'package:musix_trans/data/repositories/translation_repository.dart';
import 'package:musix_trans/utils/command.dart';
import 'package:flutter/foundation.dart';

class TranslationViewModel extends ChangeNotifier {
  TranslationViewModel({required this.translationRepository}) {
    loadTranslation = Command1<void, String>(_load);
  }

  final TranslationRepository translationRepository;

  Translation? _translation;
  List<bool> _expansionStates = [];

  Translation? get translation => _translation;
  List<bool> get expansionStates => _expansionStates;

  late final Command1 loadTranslation;

  void setExpanded(int index, bool value) {
    if (index >= 0 && index < (translation?.lines.length ?? 0)) {
      _expansionStates[index] = value;
      notifyListeners();
    }
  }

  void toggleAll(bool expand) {
    _expansionStates = List.filled((translation?.lines.length ?? 0), expand);
    notifyListeners();
  }

  Future<Result<void>> _load(String trackId) async {
    final translResult = translationRepository.getTransl(trackId);
    switch (translResult) {
      case Ok<Translation>():
        _translation = translResult.value;
        _expansionStates = List.filled(_translation!.lines.length, false);
        notifyListeners();
        return Result.ok(null);
      case Error<Translation>():
        notifyListeners();
        return Result.error(translResult.error);
    }
  }
}
