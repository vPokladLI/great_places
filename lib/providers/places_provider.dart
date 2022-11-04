import 'dart:io';
import 'package:flutter/material.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addItem(
      {required String title,
      required double latitude,
      required double longitude,
      required File image}) {
    _items.add(Place(
        id: DateTime.now().toString(),
        title: title,
        location: PlaceLocation(latitude: latitude, longitude: longitude),
        image: image));
    notifyListeners();
  }
}
