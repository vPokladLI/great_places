import 'package:flutter/material.dart';
import '../pages/add_place_screen.dart';

class PlacesScreen extends StatelessWidget {
  static String routName = '/places';

  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Great places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.secondary,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
