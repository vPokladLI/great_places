import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../helpers/maps_helper.dart';

import '../providers/places_provider.dart';
import '../models/place.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _selectedLocation;

  void selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void selectLocation(LatLng location) async {
    final address = await MapsHelper.generateAddressFromLocation(
        location.latitude, location.longitude);

    _selectedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address as String);
  }

  void _onSubmit() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _selectedLocation == null) {
      return;
    }
    context.read<Places>().addItem(
        title: _titleController.text,
        location: _selectedLocation!,
        image: _pickedImage!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add place'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ImageInput(selectImage),
                    const SizedBox(
                      height: 15,
                    ),
                    LocationInput(selectLocation),
                  ]),
                ),
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    backgroundColor: colorScheme.secondary,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    elevation: 0,
                    shape: const ContinuousRectangleBorder()),
                onPressed: _onSubmit,
                icon: const Icon(Icons.photo_size_select_actual_rounded),
                label: const Text('Add place'))
          ]),
    );
  }
}
