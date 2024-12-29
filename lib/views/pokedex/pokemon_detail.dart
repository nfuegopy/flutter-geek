import 'package:flutter/material.dart';
import '../../models/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetail({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "#${pokemon.id} - ${pokemon.name.toUpperCase()}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            Text("Sprites: Normal", style: Theme.of(context).textTheme.titleMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(pokemon.imageFrontDefault, height: 100),
                Image.network(pokemon.imageBackDefault, height: 100),
              ],
            ),
            const SizedBox(height: 16),
            Text("Sprites: Shiny", style: Theme.of(context).textTheme.titleMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(pokemon.imageFrontShiny, height: 100),
                Image.network(pokemon.imageBackShiny, height: 100),
              ],
            ),
            const SizedBox(height: 16),
            Text("Tipos:", style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8,
              children: pokemon.types
                  .map(
                    (type) => Chip(
                      label: Text(type.name.toUpperCase()),
                      backgroundColor: Colors.lightGreenAccent,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Text("Movimientos:", style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: pokemon.moves
                  .map(
                    (move) => Chip(
                      label: Text(
                        move.toUpperCase(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
