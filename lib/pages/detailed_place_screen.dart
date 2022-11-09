import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/places_provider.dart';

class DetailedPageScreen extends StatelessWidget {
  final String placeId;
  const DetailedPageScreen({required this.placeId, super.key});

  @override
  Widget build(BuildContext context) {
    Place place = context.read<Places>().findById(placeId);
    print(place.location.address);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(place.title)),
      ),
      body: Container(
        child: Text(place.location.address),
      ),
    );
  }
}
