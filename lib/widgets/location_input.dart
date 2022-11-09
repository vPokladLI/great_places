import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/maps_helper.dart';
import '../pages/map_screen.dart';
import '../models/place.dart';

class LocationInput extends StatefulWidget {
  final Function selectLocation;
  const LocationInput(this.selectLocation, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  var _isLoading = false;
  String? _previewLocation;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LatLng? _locationData;

  Location location = Location();
  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
    });
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
    LocationData locationData = await location.getLocation();
    if (locationData == null) return;
    _locationData = LatLng(locationData.latitude!, locationData.longitude!);
    final mapImageUrl = MapsHelper.generateLocationPreview(
        locationData.latitude!, locationData.longitude!);
    widget.selectLocation(_locationData);
    setState(() {
      _isLoading = false;
      _previewLocation = mapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const MapScreen(
        isSelecting: true,
      ),
    ));
    if (selectedLocation == null) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final mapImageUrl = MapsHelper.generateLocationPreview(
        selectedLocation.latitude, selectedLocation.longitude);
    setState(() {
      _isLoading = false;
      _previewLocation = mapImageUrl;
    });
    widget.selectLocation(selectedLocation);
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
          child: _isLoading
              ? const CircularProgressIndicator()
              : _previewLocation == null
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
