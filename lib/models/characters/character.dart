import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
class Character with _$Character {
  factory Character({
    String? id,
    String? name,
    String? image,
    String? status,
    String? species,
    Location? location, // last seen = locaion.name
    Episode? episode, // first seen in
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

@freezed
class Location with _$Location {
  factory Location({
    String? name,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class Episode with _$Episode {
  factory Episode({
    String? name,
  }) = _Episode;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}
