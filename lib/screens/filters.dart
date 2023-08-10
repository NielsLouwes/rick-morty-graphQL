import 'package:flutter/material.dart';
import 'package:graphql_example/models/characters/character.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_example/providers/fetch_characters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  // Note the change here
  bool _isAlive = false;
  bool _isHumanSpecies = false;

  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(fetchCharactersProvider);

    // void filterFunction() {
    //   setState(() {
    //     // Adjust this according to the exact type returned by your provider
    //     final filteredCharacters = characters.where((character) {
    //       return (character.species == 'Human' || !_isHumanSpecies) &&
    //           (character.status == 'Alive' || !_isAlive);
    //     }).toList();
    //     // Here, you might want to save the filteredCharacters somewhere to use them
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: _isHumanSpecies,
            onChanged: (bool value) {
              setState(() {
                _isHumanSpecies = value;
              });
              // filterFunction();
            },
            title: const Text('Human Species'),
          ),
          SwitchListTile(
            value: _isAlive,
            onChanged: (bool value) {
              setState(() {
                _isAlive = value;
              });
              // filterFunction();
            },
            title: const Text('Alive'),
          ),
        ],
      ),
    );
  }
}
