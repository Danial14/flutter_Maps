import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class CustomMarkers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CustomMarkers();
  }
}
class _CustomMarkers extends State<CustomMarkers>{
  Uint8List? markerIMage;
  final Completer<GoogleMapController> _completer = Completer();
  List<String> _iMages = ["assets/images/car.png", "assets/images/parking.png"];
  List<Marker> _markers = [Marker(markerId: MarkerId("1"), position: LatLng(24.9389017,67.1237318)),
    Marker(markerId: MarkerId("2"), position: LatLng(24.9323526,67.0872638))
  ];
  List<LatLng> _LatLngList = [
    LatLng(24.9389017,67.1237318),
    LatLng(24.9323526,67.0872638)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }
  _loadData() async{
    for(int i = 0; i < _iMages.length; i++){
      final Uint8List markerIcon = await getBytesFromAssets(_iMages[i], 100);
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _LatLngList[i],
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: InfoWindow(
          title: "This is custoM Marker"
        )
      ));
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Markers"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(24.9323526,67.0872638),
          zoom: 14
        ),
        onMapCreated: (controller){
          _completer.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_markers),
      ),
    );
  }
  Future<Uint8List> getBytesFromAssets(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}