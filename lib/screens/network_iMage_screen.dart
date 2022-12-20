import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class NetworkIMage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NetworkIMageState();
  }
}
class _NetworkIMageState extends State<NetworkIMage>{
  final List<LatLng> _latLngList = [LatLng(
      24.8767965,67.0599163
  ),
    LatLng(24.8867965,67.0999167),
    LatLng(24.8967965,67.0999187)
  ];
  initState(){
    super.initState();
    _loadData();
  }
  Set<Marker> _Markers = {};
  void _loadData() async{
    for(int i = 0; i < _latLngList.length; i++){
      Uint8List? iMage = await _getNetworkIMage("https://images.pexels.com/photos/919073/pexels-photo-919073.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1");
      final ui.Codec iMageCodec = await ui.instantiateImageCodec(iMage.buffer.asUint8List(), targetHeight: 50, targetWidth: 50);
      final ui.FrameInfo fraMeInfo = await iMageCodec.getNextFrame();
      final ByteData? byteData = await fraMeInfo.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List resizedIMageMarker = byteData!.buffer.asUint8List();
      _Markers.add(Marker(
        markerId: MarkerId(i.toString()),
        infoWindow: InfoWindow(title: "Window", snippet: "location"),
        icon: BitmapDescriptor.fromBytes(resizedIMageMarker),
        position: _latLngList[i]
      ));
    }
    setState(() {

    });
  }
  Future<Uint8List> _getNetworkIMage(String path) async{
    final coMpleted = Completer<ImageInfo>();
    var iMage = NetworkImage(path);
    iMage.resolve(ImageConfiguration()).addListener(ImageStreamListener((info, _){
      coMpleted.complete(info);
    }));
    final iMageInfo = await coMpleted.future;
    final byteData = await iMageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        zoom: 14,
        target: LatLng(
            24.8767965,67.0599163
        )
      ),
      markers: _Markers,
    );
  }
}