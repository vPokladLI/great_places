import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/places_list_screen.dart';
import './pages/add_place_screen.dart';

import './providers/places_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Places(),
        )
      ],
      child: MaterialApp(
        title: 'Great places',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
        home: const PlacesScreen(),
        routes: {
          AddPlaceScreen.routName: (context) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
