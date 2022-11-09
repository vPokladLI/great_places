import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  const MapScreen(
      {super.key,
      this.initialLocation =
          const PlaceLocation(latitude: 49.58, longitude: 34.55),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedLocation;

  // @override
  // void initState() {
  //   _selectedLocation = LatLng(
  //       widget.initialLocation.latitude, widget.initialLocation.longitude);
  //   super.initState();
  // }

  void _selectLocation(LatLng? position) {
    if (position != null) {
      setState(() {
        _selectedLocation = position;
      });
    }
  }

  void _confirmPosition() {
    Navigator.of(context).pop(_selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 70,
          child: FittedBox(
            child: Text(_selectedLocation == null
                ? '${widget.initialLocation.latitude.toStringAsFixed(3)}, ${widget.initialLocation.longitude.toStringAsFixed(3)}'
                : '${_selectedLocation?.latitude.toStringAsFixed(3)},  ${_selectedLocation?.longitude.toStringAsFixed(3)}'),
          ),
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _selectedLocation == null ? null : _confirmPosition,
                icon: Icon(Icons.check_box))
        ],
      ),
      body: GoogleMap(
        markers: _selectedLocation == null
            ? {}
            : {
                Marker(
                    markerId: const MarkerId('m1'),
                    position: _selectedLocation!)
              },
        onTap: widget.isSelecting ? _selectLocation : null,
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
        ),
      ),
    );
  }
}
