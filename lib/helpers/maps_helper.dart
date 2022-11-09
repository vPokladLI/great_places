import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final apiKey = dotenv.get('GOOGLE_MAP_API_KEY');

class MapsHelper {
  static String generateLocationPreview(double lat, double lon) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=15&scale=2&size=400x300&markers=size:mid%7Ccolor:red%7C$lat,$lon&key=$apiKey';
  }

  static Future<String>? generateAddressFromLocation(
      double lat, double lon) async {
    final link = Uri.https('maps.googleapis.com', 'maps/api/geocode/json',
        {'latlng': '$lat,$lon', 'key': apiKey});

    final response = await http.get(link);
    final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;

    return decodedResponse['results'][0]['formatted_address'];
  }
}
