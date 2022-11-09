import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/add_place_screen.dart';
import '../pages/detailed_place_screen.dart';
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

    Widget noItems = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No item added yet! Start adding your favorite places',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
              label: const Text('Add place'),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routName);
              },
              icon: const Icon(Icons.add))
        ],
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
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false)
            .fetchAndSeItems('places'),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? spinner
            : Consumer<Places>(
                child: noItems,
                builder: (context, places, ch) => places.items.isEmpty
                    ? ch!
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: places.items.length,
                        itemBuilder: (ctx, i) => Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'DELETE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            Provider.of<Places>(context, listen: false)
                                .deletePlace(places.items[i].id);
                          },
                          confirmDismiss: (direction) {
                            return showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text(
                                    'Do yo want to remove this awesome place?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('No, sorry!')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Yep! Delete it!')),
                                ],
                              ),
                            );
                          },
                          key: Key(places.items[i].id),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(places.items[i].image),
                            ),
                            title: Text(places.items[i].title),
                            subtitle: Text(places.items[i].location.address),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailedPageScreen(
                                    placeId: places.items[i].id),
                              ));
                            },
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Are you sure?'),
                                      content: const Text(
                                          'Do yo want to remove this awesome place?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('No, sorry!')),
                                        TextButton(
                                            onPressed: () {
                                              Provider.of<Places>(context,
                                                      listen: false)
                                                  .deletePlace(
                                                      places.items[i].id);
                                              Navigator.of(context).pop();
                                            },
                                            child:
                                                const Text('Yep! Delete it!')),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete)),
                          ),
                        ),
                      )),
      ),
    );
  }
}
