import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/maps_helper.dart';

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
        return;
      }
    }
    _locationData = await location.getLocation();
    if (_locationData == null) return;
    final mapImageUrl = MapsHelper.generateLocationPreview(
        _locationData.latitude!, _locationData.longitude!);
    widget.selectLocation(_locationData);
    setState(() {
      _previewLocation = mapImageUrl;
    });
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
              ? Text(
                  'No location is selected',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewLocation as String,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
                onPressed: () {
                  _getLocation();
                },
                icon: Icon(Icons.location_on),
                label: Text('Get user location')),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.map),
                label: Text('Select on map')),
          ],
        )
      ],
    );
  }
}
