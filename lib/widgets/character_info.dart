import 'package:flutter/material.dart';
import 'package:graphql_example/models/characters/character.dart';

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
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

    return Expanded(
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
              style: TextStyle(color: Color.fromARGB(255, 141, 147, 149)),
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
                  fontSize: 16, color: Color.fromARGB(255, 141, 147, 149)),
            ),
            Text(
              character.episode?.isNotEmpty == true
                  ? character.episode![0].name ?? 'Unknown'
                  : 'Unknown',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
