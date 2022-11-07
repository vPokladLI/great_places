import 'dart:io';
import 'package:flutter/material.dart';
import '../helpers/sql_database.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addItem(
      {required String title,
      required double latitude,
      required double longitude,
      required File image}) async {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: PlaceLocation(latitude: latitude, longitude: longitude),
        image: image);
    _items.add(newPlace);
    await DbHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
    notifyListeners();
  }

  Future<void> fetchAndSeItems(String table) async {
    List<Map<String, Object?>> storedPlaces = await DbHelper.getAll(table);
    if (storedPlaces.isEmpty) return;
    _items = storedPlaces
        .map((e) => Place(
            id: e['id'] as String,
            title: e['title'] as String,
            location: PlaceLocation(latitude: 10.0, longitude: 10.0),
            image: File(e['image'] as String)))
        .toList();
    notifyListeners();
  }

  Future<void> deletePlace(String id) async {
    await DbHelper.delete('places', id);
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
