// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranslationAdapter extends TypeAdapter<Translation> {
  @override
  final typeId = 0;

  @override
  Translation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Translation(
      sync_type: fields[0] as String,
      track_id: fields[1] as String,
      spoty_api_data: fields[2] as SpotyApiData,
      lines: (fields[3] as List).cast<Line>(),
    );
  }

  @override
  void write(BinaryWriter writer, Translation obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sync_type)
      ..writeByte(1)
      ..write(obj.track_id)
      ..writeByte(2)
      ..write(obj.spoty_api_data)
      ..writeByte(3)
      ..write(obj.lines);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpotyApiDataAdapter extends TypeAdapter<SpotyApiData> {
  @override
  final typeId = 1;

  @override
  SpotyApiData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpotyApiData(
      artists: (fields[0] as List).cast<Artist>(),
      name: fields[1] as String,
      album: fields[2] as Album,
    );
  }

  @override
  void write(BinaryWriter writer, SpotyApiData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.artists)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.album);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpotyApiDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ArtistAdapter extends TypeAdapter<Artist> {
  @override
  final typeId = 2;

  @override
  Artist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artist(name: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, Artist obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  final typeId = 3;

  @override
  Album read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Album(name: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LineAdapter extends TypeAdapter<Line> {
  @override
  final typeId = 4;

  @override
  Line read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Line(
      words: fields[0] as String,
      trans: fields[1] as String,
      comment: fields[2] as String,
      start_time_ms: (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Line obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.words)
      ..writeByte(1)
      ..write(obj.trans)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.start_time_ms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Translation _$TranslationFromJson(Map<String, dynamic> json) => Translation(
  sync_type: json['sync_type'] as String,
  track_id: json['track_id'] as String,
  spoty_api_data: SpotyApiData.fromJson(
    json['spoty_api_data'] as Map<String, dynamic>,
  ),
  lines: (json['lines'] as List<dynamic>)
      .map((e) => Line.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TranslationToJson(Translation instance) =>
    <String, dynamic>{
      'sync_type': instance.sync_type,
      'track_id': instance.track_id,
      'spoty_api_data': instance.spoty_api_data.toJson(),
      'lines': instance.lines.map((e) => e.toJson()).toList(),
    };

SpotyApiData _$SpotyApiDataFromJson(Map<String, dynamic> json) => SpotyApiData(
  artists: (json['artists'] as List<dynamic>)
      .map((e) => Artist.fromJson(e as Map<String, dynamic>))
      .toList(),
  name: json['name'] as String,
  album: Album.fromJson(json['album'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SpotyApiDataToJson(SpotyApiData instance) =>
    <String, dynamic>{
      'artists': instance.artists.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'album': instance.album.toJson(),
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) =>
    Artist(name: json['name'] as String);

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
  'name': instance.name,
};

Album _$AlbumFromJson(Map<String, dynamic> json) =>
    Album(name: json['name'] as String);

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
  'name': instance.name,
};

Line _$LineFromJson(Map<String, dynamic> json) => Line(
  words: json['words'] as String,
  trans: json['trans'] as String,
  comment: json['comment'] as String,
  start_time_ms: (json['start_time_ms'] as num).toInt(),
);

Map<String, dynamic> _$LineToJson(Line instance) => <String, dynamic>{
  'words': instance.words,
  'trans': instance.trans,
  'comment': instance.comment,
  'start_time_ms': instance.start_time_ms,
};
