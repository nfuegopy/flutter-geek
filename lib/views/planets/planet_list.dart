import 'package:flutter/material.dart';
import '../../services/api_dragon_ball_service.dart';
import '../../models/planet.dart';
import './widgets/planet_card.dart';
import 'package:getwidget/getwidget.dart';

class PlanetList extends StatefulWidget {
  @override
  _PlanetListState createState() => _PlanetListState();
}

class _PlanetListState extends State<PlanetList> {
  final apiService = ApiDragonBallService();
  List<Planet> planets = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPlanets();
  }

  Future<void> fetchPlanets() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await apiService.fetchPlanets(page: currentPage);
      setState(() {
        planets = data['planets'];
        totalPages = data['pagination']['totalPages'];
      });
    } catch (e) {
      print('Error fetching planets: $e');
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
      fetchPlanets();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      fetchPlanets();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dragon Ball Planteas'),
        backgroundColor: GFColors.PRIMARY,
      ),
      body: isLoading
          ? const Center(
              child: GFLoader(
                type: GFLoaderType.custom,
                loaderIconOne: Icon(Icons.public, color: Colors.green, size: 40),
                loaderIconTwo: Icon(Icons.circle, color: Colors.blue, size: 40),
                loaderIconThree: Icon(Icons.star, color: Colors.orange, size: 40),
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
                    itemCount: planets.length,
                    itemBuilder: (context, index) {
                      return PlanetCard(planet: planets[index]);
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
