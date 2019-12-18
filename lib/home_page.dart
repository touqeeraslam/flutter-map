import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import './details_page.dart';
import 'package:http/http.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage>  {
final Map<String, Marker> _markers = {};
Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962)
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       appBar: AppBar(
        title: Text('Google Map Sample App'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers.values.toSet(),
      ),
       floatingActionButton:  new ButtonTheme.bar(
        child: new ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
                new RaisedButton(
                  onPressed: _getLocation,
                  textColor: Colors.white,
                  child: Row( 
                  children: <Widget>[
                  Icon(Icons.add_location),
                  Text("Add Marker")
                  ],
                ),
                color: Colors.green,
                ),
                new RaisedButton(
                  onPressed: _nextPage,
                  textColor: Colors.white,
                  child: Row( 
                  children: <Widget>[
                  Icon(Icons.navigate_next),
                  Text("Next Page")
                  ],
                ),
                  color: Colors.blueGrey,
                ),
                  ],
        ),
        ),
    );
  }

  Future<void> _nextPage() async {
    //navigating from one page to another.
    Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsPage(todo:'Hello this is the data from previous page')),);
  }
 
 _getLocation() async {
  // make GET request
  String url = 'https://flutter-api-server.herokuapp.com/location';
  Response response = await get(url);
  // sample info available in response
  int statusCode = response.statusCode;
    // to convert json to object...  
  final locationInfo = jsonDecode(response.body);
    if (statusCode == 200) {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(locationInfo['lat'],locationInfo['long']),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });  } 
    else {
      print('getting error from Api');
  }

}

}