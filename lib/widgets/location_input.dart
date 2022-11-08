import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/maps_helper.dart';
import '../pages/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function selectLocation;
  const LocationInput(this.selectLocation, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location location = Location();
  String? _previewLocation;

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<void> _getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Attention!'),
            content: const Text(
                'Application needs yours permission to view location! Please confirm!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Let`s try again.'))
            ],
          ),
        );
        return;
      }
    }
    _locationData = await location.getLocation();
    // if (_locationData == null) return;
    final mapImageUrl = MapsHelper.generateLocationPreview(
        _locationData.latitude!, _locationData.longitude!);
    widget.selectLocation(_locationData);
    setState(() {
      _previewLocation = mapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const MapScreen(
        isSelecting: true,
      ),
    ));
    if (selectedLocation == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1)),
          child: _previewLocation == null
              ? const Text(
                  'No location is selected',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewLocation as String,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
                onPressed: () {
                  _getLocation();
                },
                icon: const Icon(Icons.location_on),
                label: const Text('Get user location')),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text('Select on map')),
          ],
        )
      ],
    );
  }
}
