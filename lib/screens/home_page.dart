import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_example/providers/fetch_characters_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
      ),
      body: ref.watch(fetchCharactersProvider).maybeWhen(
        fetched: (characters) {
          return ListView(
            children: characters
                .map((character) => ListTile(
                      title: Text(character.name!),
                      leading: Image.network(
                        character.image!,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      subtitle: Text(character.status!),
                    ))
                .toList(),
          );
        },
        orElse: () {
          return Container();
        },
      ),
    );
  }
}
