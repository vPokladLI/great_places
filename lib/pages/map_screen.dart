import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final LatLng initialLocation;
  final bool isSelecting;
  const MapScreen(
      {super.key,
      this.initialLocation = const LatLng(49.58, 34.55),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedLocation;

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
        title: FittedBox(
          child: widget.isSelecting
              ? const Text('Please tap on location and confirm:')
              : Text(_selectedLocation == null
                  ? '${widget.initialLocation.latitude.toStringAsFixed(3)}, ${widget.initialLocation.longitude.toStringAsFixed(3)}'
                  : '${_selectedLocation?.latitude.toStringAsFixed(3)},  ${_selectedLocation?.longitude.toStringAsFixed(3)}'),
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _selectedLocation == null ? null : _confirmPosition,
                icon: const Icon(
                  Icons.check,
                  size: 36,
                ))
        ],
      ),
      body: GoogleMap(
        markers: {
          Marker(
              markerId: const MarkerId('m1'),
              position: _selectedLocation ??
                  LatLng(widget.initialLocation.latitude,
                      widget.initialLocation.longitude))
        },
        onTap: widget.isSelecting ? _selectLocation : null,
        initialCameraPosition:
            CameraPosition(zoom: 16, target: widget.initialLocation),
      ),
    );
  }
}
