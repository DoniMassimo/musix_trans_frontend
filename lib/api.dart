import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

final String baseUri = "127.0.0.1:5000";

Future<List<String>> getTracksIds() async {
  var url = Uri.http(baseUri, '/get_tracks_ids');
  var a = {'x-api-key': dotenv.env['API_KEY'] ?? ''};
  http.Response res = await http.get(url, headers: a);
  var rawData = jsonDecode(res.body);
  return List<String>.from(rawData);
}

Future<Map> getTrackData(String trackId) async {
  var url = Uri.http(baseUri, '/get_track_data/$trackId');
  var h = {'x-api-key': dotenv.env['API_KEY'] ?? ''};
  http.Response res = await http.get(url, headers: h);
  var rawData = jsonDecode(res.body);
  return Map.from(rawData);
}
