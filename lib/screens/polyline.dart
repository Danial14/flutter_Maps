import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLine extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PolyLineState();
  }
}
class PolyLineState extends State<PolyLine>{
  Completer<GoogleMapController> _completer = Completer();
  Set<Marker> _Markers = {};
  Set<Polyline> _polyline = {};
  List<LatLng> _LatLngList = [
    LatLng(24.9389017,67.1237318),
    LatLng(24.9323526,67.0872638),
    LatLng(24.9282014,67.0750023),
    LatLng(24.9182014,67.0760023)
  ];
  @override
  initState(){
    super.initState();
    for(int i = 0; i < _LatLngList.length; i++){
      _Markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _LatLngList[i],
        infoWindow: InfoWindow(
          title: "Cool place",
          snippet: "This is cool place"
        )
      )
      );
    }
    _polyline.add(Polyline(
      polylineId: PolylineId("1"),
      points: _LatLngList
    ));
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polyline"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(24.9389017,67.1237318),
          zoom: 14
        ),
        onMapCreated: (controller){
          _completer.complete(controller);
        },
        markers: _Markers,
        polylines: _polyline,
      ),
    );
  }
}