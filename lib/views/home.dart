import 'package:flutter/material.dart';
import './anime/anime_home.dart'; // Nueva sección de Anime
import './planets/planet_list.dart'; // Planetas como sección separada

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mega Friki Api'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildHomeCard(
              context,
              title: "Anime",
              icon: Icons.tv,
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnimeHome()), // Nueva vista
              ),
            ),
            // _buildHomeCard(
            //   context,
            //   title: "Series",
            //   icon: Icons.people,
            //   color: Colors.green,
            //   onTap: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => PlanetList()),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
