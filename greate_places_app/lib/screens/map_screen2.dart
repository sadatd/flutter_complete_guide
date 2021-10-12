import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen2 extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelected;

  MapScreen2(
      {this.initialLocation = const PlaceLocation(
        latitude: 42.655075,
        longitude: 21.163951,
      ),
      this.isSelected = false});

  @override
  _MapScreen2State createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
      ),
    );
  }
}
