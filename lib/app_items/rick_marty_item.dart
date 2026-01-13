
import 'package:flutter/material.dart';
import 'package:rickmarty/model/character.dart';

class RickMartyItem extends StatelessWidget {
  final Character character;
  final GestureTapCallback press;

  const RickMartyItem({super.key, required this.character, required this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.blue.withOpacity(0.7),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      "Alive - ${character.species}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: press,
                  icon: Icon(
                    character.isFavorite ? Icons.star : Icons.star_border,
                    color: character.isFavorite ? Colors.amber : Colors.grey,
                    size: 35,
                  ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Last known location:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            character.locationName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            "First seen in:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "Pilot",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
