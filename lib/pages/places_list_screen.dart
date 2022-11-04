import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/add_place_screen.dart';
import '../providers/places_provider.dart';

class PlacesScreen extends StatelessWidget {
  static String routName = '/places';

  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget spinner = Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.secondary,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: colorScheme.primary,
          color: colorScheme.onSecondary,
        ),
      ),
    );

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
      body: Consumer<Places>(
          child: Text('No items'),
          builder: (context, places, ch) => places.items.isEmpty
              ? ch!
              : ListView.builder(
                  itemCount: places.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(places.items[i].image),
                    ),
                    title: Text(places.items[i].title),
                    onTap: () {
                      //TODO implement detailed view
                    },
                  ),
                )),
    );
  }
}
