import 'package:json_annotation/json_annotation.dart';
import 'package:hive_ce/hive_ce.dart';

part 'translation.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class Translation {
  @HiveField(0)
  final String sync_type;

  @HiveField(1)
  final String track_id;

  @HiveField(2)
  final SpotyApiData spoty_api_data;

  @HiveField(3)
  final List<Line> lines;

  Translation({
    required this.sync_type,
    required this.track_id,
    required this.spoty_api_data,
    required this.lines,
  });

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class SpotyApiData {
  @HiveField(0)
  final List<Artist> artists;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final Album album;

  SpotyApiData({
    required this.artists,
    required this.name,
    required this.album,
  });

  factory SpotyApiData.fromJson(Map<String, dynamic> json) =>
      _$SpotyApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$SpotyApiDataToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class Artist {
  @HiveField(0)
  final String name;

  Artist({required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class Album {
  @HiveField(0)
  final String name;

  Album({required this.name});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

@HiveType(typeId: 4)
@JsonSerializable()
class Line {
  Line({
    required this.words,
    required this.trans,
    required this.comment,
    required this.start_time_ms,
  });

  @HiveField(0)
  final String words;

  @HiveField(1)
  final String trans;

  @HiveField(2)
  final String comment;

  @HiveField(3)
  final int start_time_ms;

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);

  Map<String, dynamic> toJson() => _$LineToJson(this);
}
