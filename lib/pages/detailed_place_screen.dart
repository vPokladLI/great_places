import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/places_provider.dart';
import '../pages/map_screen.dart';

class DetailedPageScreen extends StatelessWidget {
  final String placeId;
  const DetailedPageScreen({required this.placeId, super.key});

  @override
  Widget build(BuildContext context) {
    Place place = context.read<Places>().findById(placeId);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(place.title)),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 400,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapScreen(
                    initialLocation: LatLng(
                        place.location.latitude, place.location.longitude),
                    isSelecting: false,
                  ),
                ));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.pin_drop,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Expanded(
                    child: Text(
                      place.location.address,
                      softWrap: true,
                      style: const TextStyle(color: Colors.black38),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
