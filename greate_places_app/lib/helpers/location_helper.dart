import 'package:geocoding/geocoding.dart';

const GOOGLE_API_KEY = 'AIzaSyB41DRUbKWJHPxaFjMAwdrzWzbVKartNGg'; // from internet
const MAP_API_KEY = 'iPG0E3yuKBfQ0MXiA9jSYuISA6mYrMLD';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude}) {
    // return 'https://www.mapquestapi.com/staticmap/v5/map?key=$MAP_API_KEY&center=$latitude,$longitude&zoom=16&size=@2x';
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=300x300&maptype=roadmap&markers=color:red%7Clabel:C$latitude,$longitude&key=$GOOGLE_API_KEY'; // Google
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    final address = '${placemarks[0].locality}, ${placemarks[0].street}';
    return address;
  }
}