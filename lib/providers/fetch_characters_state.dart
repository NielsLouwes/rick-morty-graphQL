import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_example/models/characters/character.dart';

part 'fetch_characters_state.freezed.dart';

@freezed
class FetchCharactersState with _$FetchCharactersState {
  @FreezedUnionValue('initial')
  factory FetchCharactersState.initial() = _Initial;

  @FreezedUnionValue('fetching')
  factory FetchCharactersState.fetching() = _Fetching;

  @FreezedUnionValue('fetched')
  factory FetchCharactersState.fetched(List<Character> characters) = _Fetched;

  @FreezedUnionValue('failed')
  factory FetchCharactersState.failed(String error) = _Failed;
}
