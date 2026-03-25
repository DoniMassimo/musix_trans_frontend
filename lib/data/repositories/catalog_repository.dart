import 'package:musix_trans/models/translation/translation.dart';
import 'package:musix_trans/utils/result.dart';
import 'package:musix_trans/data/services/api_client.dart';
import 'package:musix_trans/data/services/local_data.dart';
import 'package:musix_trans/models/catalog_enrty/catalog_entry.dart';

class CatalogRepository {
  CatalogRepository({
    required LocalData localData,
    required ApiClient apiClient,
  }) : _localData = localData,
       _apiClient = apiClient;

  final LocalData _localData;
  final ApiClient _apiClient;

  Result<List<CatalogEntry>> getCatalog() {
    final allTranslRes = _localData.getAllTransl();
    final List<Translation> allTransl;
    switch (allTranslRes) {
      case Ok<List<Translation>>():
        allTransl = allTranslRes.value;
        break;
      case Error():
        return Result.error(allTranslRes.error);
    }
    try {
      final catalog = allTransl
          .map(
            (transl) => CatalogEntry(
              trackId: transl.track_id,
              song: transl.spoty_api_data.name,
              album: transl.spoty_api_data.album.name,
              artist: transl.spoty_api_data.artists[0].name,
            ),
          )
          .toList();
      return Result.ok(catalog);
    } catch (e) {
      return Result.error(
        FormatException('Error while parsing Translations', e),
      );
    }
  }

  Future<Result<List<Result<String>>>> syncCatalog() async {
    final localFuture = _localData.getTranslIds();
    final remoteFuture = _apiClient.getTranslIds();

    final localCatalogIdsResult = await localFuture;
    final remoteCatalogIdsResult = await remoteFuture;

    List<String> localCatalogIds;
    List<String> remoteCatalogIds;

    switch (localCatalogIdsResult) {
      case Ok<List<String>>():
        localCatalogIds = localCatalogIdsResult.value;
        break;
      case Error():
        return Result.error(localCatalogIdsResult.error);
    }

    switch (remoteCatalogIdsResult) {
      case Ok<List<String>>():
        remoteCatalogIds = remoteCatalogIdsResult.value;
        break;
      case Error<List<String>>():
        return Result.error(remoteCatalogIdsResult.error);
    }

    final missingLocal = remoteCatalogIds
        .toSet()
        .difference(localCatalogIds.toSet())
        .toList();

    final translFututres = missingLocal
        .map((trackId) => _apiClient.getTransl(trackId))
        .toList();

    final List<Result<Translation>> translResults = await Future.wait(
      translFututres,
    );

    final saveTranslFutures = List<Future<Result<String>>>.from(
      translResults.map((translResult) {
        switch (translResult) {
          case Ok():
            return _localData.saveTransl(translResult.value);
          case Error():
            return translResult;
        }
      }).toList(),
    );
    final List<Result<String>> saveTranslResults = await Future.wait(
      saveTranslFutures,
    );
    return Result.ok(saveTranslResults);
  }
}
