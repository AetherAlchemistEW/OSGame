import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class Map extends StatefulWidget {

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          new FlutterMap(
            options: new MapOptions(
              center: new LatLng(-37, 144),
              zoom: 13.0,
            ),
            layers: [
              new TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a','b','c'],
                maxZoom: 5,
              ),
              new MarkerLayerOptions(
                markers: [
                  new Marker(
                    width: 80.0,
                    height: 80.0,
                    point: new LatLng(-37, 144),
                    builder: (ctx) =>
                    new Container(
                      child: new FlutterLogo(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          FloatingActionButton(
            onPressed: () => Navigator.pop(context),
            elevation: 2,
            backgroundColor: Colors.black87,
            tooltip: 'Exit Map',
            child: Icon(Icons.transit_enterexit, color: Theme.of(context).iconTheme.color,),
          ),
        ],
      ),
    );
  }
}
