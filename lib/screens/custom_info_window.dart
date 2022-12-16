import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CustomMarkerInfoWindowState();
  }
}
class CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow>{
  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  final List<Marker> _Markers = [];
  final List<LatLng> _latLngList = [
    LatLng(24.9389017,67.1237318),
    LatLng(24.9323526,67.0872638)
  ];
  @override
  void initState() {
    super.initState();
    for(int i = 0; i < _latLngList.length; i++){
      _Markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _latLngList[i],
        icon: BitmapDescriptor.defaultMarker,
        onTap: (){
          _customInfoWindowController.addInfoWindow!(ListView(children: [Container(
            width: 300,
            height: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://cdn.britannica.com/77/170477-050-1C747EE3/Laptop-computer.jpg"),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                //Text("Maps")
                SizedBox(
                  height: 10,
                ),
                Padding(padding: EdgeInsets.all(10),
                  child: Row(children: <Widget>[
                    Text("Beef tacos"),
                    Spacer(),
                    Text("0.3 Ml")
                  ],
                  ),
                ),
                Expanded(child: Padding(padding: EdgeInsets.all(10),
                  child: Text("Delicious beef tacos fkllklflc ,jkdmdmklcmkdlmlc,kfjvnm  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn ,jkdmdmklcmkdlmlc,kfjvnm  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn,jkdmdmklcmkdlmlc,kfjvnm  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn,jkdmdmklcmkdlmlc,kfjvnm  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn,jkdmdmklcmkdlmlc,kfjvnm  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn,jkdmdmklcmkdlmlc,kfjvnm  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn,jkdmdmklcmkdlmlc,kfjvnm,jkdmdmklcmkdlmlc,kfjvnm  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn,jkdmdmklcmkdlmlc,kfjvnm  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn,jkdmdmklcmkdlmlc,kfjvnm  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn  vmfnjnmcm, f,nknc kdkmlm knrivngnkndlmkfnk m jknjilndn  dkdn", softWrap: true,),
                ),)
              ],
            ),
          ),]),
              _latLngList[i]);
        }
      ));
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("CustoM window"),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(24.9389017,67.1237318),
              zoom: 14
            ),
            onMapCreated: (controller){
              _customInfoWindowController.googleMapController = controller;
            },
            markers: Set.of(_Markers),
            onTap: (position){
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position){

            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 350,
            width: 300,
            offset: 35,
          )
        ],
      )
    );
  }
}