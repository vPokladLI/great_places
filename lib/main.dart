import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import './pages/places_list_screen.dart';
import './pages/add_place_screen.dart';

import './providers/places_provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
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
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo, secondary: Colors.amber)),
        home: const PlacesScreen(),
        routes: {
          AddPlaceScreen.routName: (context) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
