import 'package:flutter/material.dart';
import '../../services/api_pokedex_service.dart';
import '../../models/pokemon.dart';
import './widgets/pokemon_card.dart';
import 'package:getwidget/getwidget.dart';

class PokedexList extends StatefulWidget {
  @override
  _PokedexListState createState() => _PokedexListState();
}

class _PokedexListState extends State<PokedexList> {
  final apiService = ApiPokedexService();
  List<Pokemon> pokemons = [];
  int currentPage = 1;
  int totalPages = 8; // Suponiendo 151 Pokémon y un límite de 20 por página
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    setState(() {
      isLoading = true;
    });
    try {
      final List<Pokemon> data = await apiService.fetchPokemons(page: currentPage);
      setState(() {
        pokemons = data;
      });
    } catch (e) {
      print('Error fetching Pokémon: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void nextPage() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
      });
      fetchPokemons();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      fetchPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokédex"),
        backgroundColor: GFColors.DANGER,
      ),
      body: Column(
        children: [
          isLoading
              ? const Center(
                  child: GFLoader(type: GFLoaderType.circle),
                )
              : Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: pokemons.length,
                    itemBuilder: (context, index) {
                      return PokemonCard(pokemon: pokemons[index]);
                    },
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GFButton(
                  onPressed: previousPage,
                  text: "Previous",
                  type: GFButtonType.outline,
                ),
                Text("Page $currentPage of $totalPages"),
                GFButton(
                  onPressed: nextPage,
                  text: "Next",
                  type: GFButtonType.outline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
