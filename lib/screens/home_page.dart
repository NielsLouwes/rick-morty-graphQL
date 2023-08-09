import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_example/providers/fetch_characters_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget returnStatusCircle(status) {
      if (status == 'Alive') {
        return const Icon(
          Icons.circle,
          color: Colors.green,
          size: 14,
        );
      }
      if (status == 'unknown') {
        return const Icon(
          Icons.circle,
          color: Colors.grey,
          size: 14,
        );
      }
      if (status == 'Dead') {
        return const Icon(
          Icons.circle,
          color: Colors.red,
          size: 14,
        );
      }

      return const SizedBox.shrink();
    }

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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      character.name!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        returnStatusCircle(character.status),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '${character.status!} - ${character.species}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Last known location:',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 141, 147, 149)),
                                    ),
                                    Text(
                                      character.location?.name ?? 'Unknown',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'First seen in:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 141, 147, 149)),
                                    ),
                                    Text(
                                      character.episode?.isNotEmpty == true
                                          ? character.episode![0].name ??
                                              'Unknown'
                                          : 'Unknown',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
