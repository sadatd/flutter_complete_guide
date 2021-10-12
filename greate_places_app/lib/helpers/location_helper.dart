const MAP_API_KEY = 'iPG0E3yuKBfQ0MXiA9jSYuISA6mYrMLD';
const GOOGLE_API_KEY = 'AIzaSyB41DRUbKWJHPxaFjMAwdrzWzbVKartNGg'; // waiting for one :)


class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude}) {
    // return 'https://www.mapquestapi.com/staticmap/v5/map?key=$MAP_API_KEY&center=$latitude,$longitude&zoom=16&size=@2x';
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=300x300&maptype=roadmap&markers=color:red%7Clabel:C$latitude,$longitude&key=$GOOGLE_API_KEY'; // Google
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}