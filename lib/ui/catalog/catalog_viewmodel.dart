import 'package:flutter/foundation.dart';
import 'package:musix_trans/utils/result.dart';
import 'package:musix_trans/models/catalog_enrty/catalog_entry.dart';
import 'package:musix_trans/data/repositories/catalog_repository.dart';
import 'package:musix_trans/utils/command.dart';

class CatalogViewModel extends ChangeNotifier {
  CatalogViewModel({required CatalogRepository catalogRepository})
    : _catalogRepository = catalogRepository {
    loadCatalog = Command0<void>(_load);
    syncCatalog = Command0<void>(_sync);
  }

  final CatalogRepository _catalogRepository;

  List<CatalogEntry>? _catalog;
  String _searchQuery = '';

  late final Command0<void> loadCatalog;
  late final Command0<void> syncCatalog;

  List<CatalogEntry>? get catalog {
    if (_catalog == null) return null;
    if (_searchQuery.isEmpty) return _catalog;
    return _catalog!.where((entry) {
      return entry.song.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<Result<void>> _load() async {
    final catalogResult = _catalogRepository.getCatalog();
    switch (catalogResult) {
      case Ok<List<CatalogEntry>>():
        _catalog = catalogResult.value;
        notifyListeners();
        return Result.ok(null);
      case Error<List<CatalogEntry>>():
        return Result.error(catalogResult.error);
    }
  }

  Future<Result<void>> _sync() async {
    final catalogResult = await _catalogRepository.syncCatalog();
    switch (catalogResult) {
      case Ok():
        await loadCatalog.execute();
        return loadCatalog.result ?? Result.error(Exception("Load failed"));
      case Error():
        return Result.error(catalogResult.error);
    }
  }
}
