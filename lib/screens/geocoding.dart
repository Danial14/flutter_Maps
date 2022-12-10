import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
class GeoCoding extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _GeoCodingState();
  }
}
class _GeoCodingState extends State<GeoCoding>{
  String _streetAddress = "";
  String _stAd = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(_streetAddress),
        Text(_stAd),
        Ink(
          child: InkWell(onTap: () async{
            List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
            List<Placemark> placeMarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
            setState(() {
              _streetAddress = locations.last.latitude.toString() + " , " + locations.last.longitude.toString();
              _stAd = placeMarks.last.country! + " , " + placeMarks.last.locality!;
            });
          },child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 50,
              width: 200,
              decoration: const BoxDecoration(
                  color: Colors.green
              ),
              child: Center(child: Text("Convert",),),
            ),
          ),),
        )

      ],
    ))
    );
  }
}