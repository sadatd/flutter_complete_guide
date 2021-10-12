import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatelessWidget {
  final LatLng target;
  final double zoom;

  MyMap({this.target, this.zoom = 13});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: target,
        zoom: zoom,
        allowPanning: false,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 100.0,
              height: 100.0,
              point: target,
              builder: (ctx) => Container(
                child: Icon(Icons.location_on, color: Colors.red, size: 32,),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
