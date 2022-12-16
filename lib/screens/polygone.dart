import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneExaMple extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PolygoneState();
  }
}
class _PolygoneState extends State<PolygoneExaMple>{
  Completer<GoogleMapController> _coMpleter = Completer();
  final Set<Marker> _Markers = {};
  Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> _latLngList = [
    LatLng(24.9187643,67.0321757),
    LatLng(24.9341571,67.0347892),
    //LatLng(24.9587643,67.0331757)
  ];
  @override
  void initState() {
    super.initState();
    for(int i = 0; i < _latLngList.length; i++){
      _Markers.add(Marker(markerId: MarkerId(i.toString()), position: _latLngList[i]));
    }
    _polygon.add(Polygon(
        polygonId: PolygonId("1"),
        geodesic: true,
      points: _latLngList,
      strokeColor: Colors.deepOrange,
      strokeWidth: 6,
      fillColor: Colors.red.withOpacity(0.5)
    ));
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polygone"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(24.9187643,67.0321757),
          zoom: 14
        ),
        onMapCreated: (controller){
          _coMpleter.complete(controller);
        },
        myLocationEnabled: false,
        markers: _Markers,
        polygons: _polygon,
      ),
    );
  }
}