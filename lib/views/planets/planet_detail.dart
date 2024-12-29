import 'package:flutter/material.dart';
import '../../models/planet.dart';

class PlanetDetail extends StatelessWidget {
  final Planet planet;

  const PlanetDetail({Key? key, required this.planet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                planet.imageUrl,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Name: ${planet.name}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "Description:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              planet.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              "Status: ${planet.isDestroyed ? 'Destroyed' : 'Active'}",
              style: TextStyle(
                color: planet.isDestroyed ? Colors.red : Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
