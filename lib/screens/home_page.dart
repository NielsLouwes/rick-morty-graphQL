import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_example/providers/fetch_characters_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_example/widgets/character_info.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

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
          title: const Text('Characters'),
          centerTitle: true,
        ),
        body: ref.watch(fetchCharactersProvider).maybeWhen(
          fetching: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          fetched: (characters) {
            return ListView(
              children: characters
                  .map((character) => Card(
                        color: const Color.fromARGB(255, 69, 68, 68),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10), // Adjust as needed
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image to the left
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10), // Image border
                              child: Image.network(
                                character.image!,
                                height: 175,
                                fit: BoxFit.cover,
                                width: 160, // Adjust the width as needed
                              ),
                            ),
                            // Adding a little spacing between image and text
                            const SizedBox(width: 10),
                            // Text content to the right of the image
                            CharacterInfo(
                              character: character,
                            )
                          ],
                        ),
                      ))
                  .toList(),
            );
          },
          orElse: () {
            return Container();
          },
        ),
      ),
    );
  }
}
