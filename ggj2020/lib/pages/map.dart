import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';
import 'package:location/location.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  StreamController<LocationData> locationStreamController;
  Stream<LocationData> locationStream;
  StreamSink<LocationData> locationSink;
  MapController mapController;
  bool initialSet = false;

  LocationData blankData = LocationData.fromMap({
    'latitude': 0,
    'longitude': 0,
    'accuracy': 0,
    'altitude': 0,
    'speed': 0,
    'speed_accuracy': 0,
    'heading': 0,
    'time': 0,
  });

  @override
  void initState() {
    super.initState();
    locationStreamController = PublishSubject<LocationData>();
    locationStream = locationStreamController.stream;
    locationSink = locationStreamController.sink;
    mapController = MapController();

    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    locationStreamController.close();
    locationSink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
          child: StreamBuilder<LocationData>(
              initialData: blankData,
              stream: locationStream,
              builder: (context, snapshot) {
                return Stack(
                  children: <Widget>[
                    _buildMap(
                        context,
                        new LatLng(
                            snapshot.data.latitude, snapshot.data.longitude)),
                    //new LatLng(snapshot.data.latitude, snapshot.data.longitude)),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          RaisedButton(
                            elevation: 5,
                            onPressed: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              verticalDirection: VerticalDirection.up,
                              children: <Widget>[
                                //Text("Attribution"),
                                RaisedButton(
                                  elevation: 5,
                                  onPressed: () => _mapCentre(
                                      new LatLng(snapshot.data.latitude,
                                          snapshot.data.longitude),
                                      13),
                                  child: Icon(
                                    Icons.filter_center_focus,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                                _details(context, snapshot.data),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })
      ),
    );
  }

  void _mapCentre(LatLng pos, double zoom){
    mapController.move(pos, zoom);
  }

  Widget _buildMap(BuildContext context, LatLng pos) {
    return new FlutterMap(
      mapController: mapController,
      options: new MapOptions(
        center: pos,
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          maxZoom: 5,
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: pos,
              builder: (ctx) => new Container(
                child: new FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //LOCATION HANDLING
  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                locationSink.add(result);
                if(initialSet == false) {
                  _mapCentre(new LatLng(location.latitude, location.longitude), 13);
                  initialSet = true;
                }
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      locationSink.add(location);
    });
  }

  slowRefresh() async {
    _locationSubscription.cancel();
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.BALANCED, interval: 10000);
    _locationSubscription =
        _locationService.onLocationChanged().listen((LocationData result) {
      if (mounted) {
        setState(() {
          locationSink.add(result);
        });
      }
    });
  }

  Widget _details(BuildContext context, LocationData data) {
    return Container(
      color: Colors.black87,
        child: Text("Lat:${data.latitude} | Long:${data.longitude}")
    );
  }
}
