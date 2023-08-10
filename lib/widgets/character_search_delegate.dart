import 'package:flutter/material.dart';
import 'package:graphql_example/models/characters/character.dart';
import 'package:graphql_example/widgets/character_info.dart';

class CharacterSearchDelegate extends SearchDelegate {
  final List<Character> characters;

  CharacterSearchDelegate(this.characters);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = characters
        .where((character) =>
            character.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.black,
      child: ListView(
        children: results
            .map((character) => Card(
                  color: const Color.fromARGB(255, 69, 68, 68),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // Adjust as needed
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
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = characters
        .where((character) =>
            character.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final character = suggestions[index];
        return ListTile(
          leading: Image.network(character.image!),
          title: Text(character.name!),
          onTap: () {
            // Populate the search page with the selected character
            query = character.name!;
          },
        );
      },
    );
  }
}
