import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add place'),
      ),
      body: Container(),
    );
  }
}
