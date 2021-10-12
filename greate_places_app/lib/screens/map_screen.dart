import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/my_map.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelected;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 42.655075, longitude: 21.163951),
      this.isSelected = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
      ),
      body: MyMap(
        target: LatLng(
          widget.initialLocation.latitude,
          widget.initialLocation.longitude,
        ),
      ),
    );
  }
}
