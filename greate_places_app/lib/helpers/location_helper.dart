const MAP_API_KEY = 'iPG0E3yuKBfQ0MXiA9jSYuISA6mYrMLD';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude}) {
    return 'https://www.mapquestapi.com/staticmap/v5/map?key=$MAP_API_KEY&center=$latitude,$longitude&zoom=16&size=@2x';
  }
}