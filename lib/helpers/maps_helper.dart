import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapsHelper {
  static String generateLocationPreview(double lat, double lon) {
    final apiKey = dotenv.get('GOOGLE_MAP_API_KEY');
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=15&scale=2&size=400x300&markers=size:mid%7Ccolor:red%7C$lat,$lon&key=$apiKey';
  }
}
