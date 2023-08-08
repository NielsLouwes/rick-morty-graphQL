import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_example/models/characters/character.dart';
import 'package:graphql_example/providers/fetch_characters_state.dart';

final fetchCharactersProvider =
    StateNotifierProvider<FetchCharactersProvider, FetchCharactersState>(
        (ref) => FetchCharactersProvider(FetchCharactersState.initial())
          ..fetchCharacters());

class FetchCharactersProvider extends StateNotifier<FetchCharactersState> {
  FetchCharactersProvider(super.state);

  fetchCharacters() async {
    state = FetchCharactersState.fetching();

    try {
      Dio dio = Dio(); // create a dio class
      var response = await dio.post(
          'https://rickandmortyapi.com/graphql', // response variable that makes dio.post request to our URL

          data: {
            'query': r'''
              query {
                characters {
                  results {
                    id
                    name
                    species
                    gender
                    image
                    status
                  }
                }
              }
              '''
          });
      List<dynamic> responseData =
          response.data['data']['characters']['results'];
      state = FetchCharactersState.fetched(
          responseData.map((e) => Character.fromJson(e)).toList());
    } on DioException catch (e) {
      // use Dio to handle an exception
      state = FetchCharactersState.failed(e.message!);
    } catch (e) {
      state = FetchCharactersState.failed('Failed to fetch Characters');
    }
  }
}
