import 'package:flutter/material.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  final List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  addItem({id, title, latitude, longitude, image}) {
    _items.add(Place(
        id: id,
        title: title,
        location: PlaceLocation(latitude: latitude, longitude: longitude),
        image: image));
  }
}
