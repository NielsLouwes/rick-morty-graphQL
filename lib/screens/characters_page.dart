import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_example/models/characters/character.dart';
import 'package:graphql_example/providers/fetch_characters_provider.dart';
import 'package:graphql_example/widgets/character_info.dart';
import 'package:graphql_example/widgets/character_search_delegate.dart';

class CharactersPage extends ConsumerWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Characters', style: TextStyle(fontSize: 28)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                final characters = ref.read(fetchCharactersProvider).maybeWhen(
                      fetched: (characters) => characters,
                      orElse: () => <Character>[],
                    );
                showSearch(
                  context: context,
                  delegate: CharacterSearchDelegate(characters),
                );
              },
            ),
          ],
        ),
        body: ref.watch(fetchCharactersProvider).maybeWhen(
              fetching: () => const Center(child: CircularProgressIndicator()),
              fetched: (List<Character> characters) {
                return ListView(
                  children: characters
                      .map((character) => Card(
                            color: const Color.fromARGB(255, 69, 68, 68),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10), // Adjust as needed
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    character.image!,
                                    height: 175,
                                    fit: BoxFit.cover,
                                    width: 160,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                CharacterInfo(
                                  character: character,
                                )
                              ],
                            ),
                          ))
                      .toList(),
                );
              },
              orElse: () => Container(),
            ),
      ),
    );
  }
}
