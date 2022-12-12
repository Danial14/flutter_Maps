import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}
class _HomeScreenState extends State<HomeScreen>{
  Completer<GoogleMapController> _coMpleter = Completer();
  List<Marker> _Markers = [];
  List<Marker> _list = [
    Marker(markerId: MarkerId("1"),
    position: LatLng(24.9323526,67.0872638),
      infoWindow: InfoWindow(
        title: "My position"
      )
    ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(24.9435357,67.0471933),
      infoWindow: InfoWindow(
        title: "IMaM clinic"
      )
    ),
    Marker(
      markerId: MarkerId("3"),
      position: LatLng(31.98953274050448,35.881326499999965),
      infoWindow: InfoWindow(
        title: "MADINA-TUL-MUNNAWARA"
      )
    )
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Markers.addAll(_list);
  }
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(24.9323526,67.0872638),
    zoom: 14
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        onMapCreated: (GoogleMapController googleMapController){
          _coMpleter.complete(googleMapController);
        },
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        markers: _Markers.toSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          getUserCurrentLocation().then((value) async{
            print("current location");
            print(value.latitude);
            print(value.longitude);
            _Markers.add(Marker(
              markerId: MarkerId("4"),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(
                title: "New location"
              )
            ));
            GoogleMapController controller = await _coMpleter.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14
            )));
            setState(() {

            });
          });

        },
        child: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value){}).onError((error, stackTrace){
      print("error : ${error}");
    });
    return await Geolocator.getCurrentPosition();
  }
}