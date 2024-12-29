import 'package:flutter/material.dart';
import '../../services/api_dragon_ball_service.dart';
import '../../models/character.dart';
import './widgets/character_card.dart';
import 'package:getwidget/getwidget.dart';

class CharacterList extends StatefulWidget {
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
 final apiService = ApiDragonBallService();
  List<Character> characters = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await apiService.fetchCharacters(page: currentPage);
      setState(() {
        characters = data['characters'];
        totalPages = data['pagination']['totalPages'];
      });
    } catch (e) {
      print('Error fetching characters: $e');
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
      fetchCharacters();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      fetchCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dragon Ball Personajes'),
        backgroundColor: GFColors.PRIMARY,
      ),
      body: isLoading
          ? const Center(
              child: GFLoader(
                type: GFLoaderType.custom,
                loaderIconOne: Icon(Icons.star, color: Colors.yellow, size: 40),
                loaderIconTwo: Icon(Icons.circle, color: Colors.deepPurple, size: 40),
                loaderIconThree: Icon(Icons.favorite, color: Colors.red, size: 40),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Número de columnas
                      childAspectRatio: 0.75, // Proporción ancho/alto
                      crossAxisSpacing: 8, // Espaciado horizontal
                      mainAxisSpacing: 8, // Espaciado vertical
                    ),
                    padding: const EdgeInsets.all(8),
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(character: characters[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: previousPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GFColors.SECONDARY,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Atras"),
                      ),
                      Text(
                        "Page $currentPage of $totalPages",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ElevatedButton(
                        onPressed: nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GFColors.SECONDARY,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Siguiente"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
