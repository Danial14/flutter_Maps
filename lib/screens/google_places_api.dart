import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _GooglePlacesApiState();
  }
}
class _GooglePlacesApiState extends State<GooglePlacesApiScreen>{
  TextEditingController _controller = TextEditingController();
  List<dynamic> _placesList = [];
  var uid = Uuid();
  String _sessionToken = "123456";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      _onChange();
    });
  }
  void _onChange(){
    if(_sessionToken == null){
      setState(() {
        _sessionToken = uid.v4();
      });
    }
    _getSuggestion(_controller.text);
  }
  void _getSuggestion(String input) async{
     final String API_KEY = "AIzaSyBLGbHk65UG3OaEWEyx9nmvZ7zKWPvjIeM";
     String baseURL =
         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
     String request = '$baseURL?input=$input&key=$API_KEY&sessiontoken=$_sessionToken';
     try{
       final response = await http.get(Uri.parse(request));
       print("places response");
       print(response.body);
       if(response.statusCode == 200){
         setState(() {
           _placesList = jsonDecode(response.body.toString())["predictions"];
         });
       }
     }
     catch(ex){
       print(ex);
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google places api"),
      ),
      body: Padding(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _controller,
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (ctx, ind){
                return ListTile(
                  onTap: () async{
                    print("user inputted location");
                    List<Location> locations = await locationFromAddress(_placesList[ind]["description"]);
                    print(locations.last.latitude);
                    print(locations.last.longitude);
                  },
                  title: Text(
                    _placesList[ind]["description"]
                  ),
                );
              },
              itemCount: _placesList.length,
              ),
            )
          ],
        ),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}