import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTheMe extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MapTheMeState();
  }
}
class _MapTheMeState extends State<MapTheMe>{
  String _MapTheme = "";
  Completer<GoogleMapController> _completer = Completer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString("assets/Map_theMe/silver_map_theMe.json").then((value){
      _MapTheme = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Map theMing"),
      actions: <Widget>[
        PopupMenuButton(itemBuilder: (BuildContext context) {
          return [PopupMenuItem(
            onTap: (){
              _completer.future.then((cont){
                DefaultAssetBundle.of(context).loadString("assets/Map_theMe/silver_map_theMe.json").then((value){
                  cont.setMapStyle(value);
                });
              });
            },
            child: Text("Silver"),
          ),
            PopupMenuItem(
              onTap: (){
                _completer.future.then((cont){
                  DefaultAssetBundle.of(context).loadString("assets/Map_theMe/dark_theMe.json").then((value){
                    cont.setMapStyle(value);
                  });
                });

              },
              child: Text("Dark"),
            )
        ];
        }
        )
      ],
    ),
    body: GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(24.8767965,67.0599163),
          zoom: 14
      ),
      onMapCreated: (controller){
        controller.setMapStyle(_MapTheme);
        _completer.complete(controller);
      },
    ),
    );
  }
}