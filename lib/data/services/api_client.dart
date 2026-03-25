import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:musix_trans/utils/result.dart';
import 'package:musix_trans/models/translation/translation.dart';

class ApiClient {
  ApiClient({required String apiKey, String? host, int? port})
    : _host = host ?? 'localhost',
      _port = port,
      _apiKey = apiKey {
    url = Uri.parse(_port != null ? 'https://$_host:$_port' : 'https://$_host');
  }

  late Uri url;
  final String _host;
  final String _apiKey;
  final int? _port;

  Future<Result<List<String>>> getTranslIds() async {
    final header = {'x-api-key': _apiKey};
    try {
      Uri fullUrl = url.replace(path: "${url.path}/translations_ids");
      final response = await http.get(fullUrl, headers: header);
      if (response.statusCode == 200) {
        final List<String> dati = List<String>.from(jsonDecode(response.body));
        return Result.ok(dati);
      }
      return Result.error(http.ClientException('error'));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<Translation>> getTransl(String translId) async {
    final header = {'x-api-key': _apiKey};
    try {
      Uri fullUrl = url.replace(path: "${url.path}/translations/$translId");
      final response = await http.get(fullUrl, headers: header);
      if (response.statusCode == 200) {
        Translation translation = Translation.fromJson(
          jsonDecode(response.body)['lyric'],
        );
        return Result.ok(translation);
      }
      return Result.error(HttpException('error'));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
