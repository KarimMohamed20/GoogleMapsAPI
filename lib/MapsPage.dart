import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsDemo extends StatefulWidget {
  final double lat;
  final double lng;
  final address;
  final city;
  MapsDemo(
      {@required this.lat,
      @required this.lng,
      @required this.address,
      @required this.city});
  @override
  State createState() => MapsPageState();
}

class MapsPageState extends State<MapsDemo> {
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 27, 76, 1),
          title: new Text('Location'),
        ),
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              options: GoogleMapOptions(
              ),
            ),
          ),
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        new CameraPosition(
            bearing: 270.0,
            target: LatLng(widget.lat, widget.lng),
            zoom: 9.0,
            tilt: 30.0,
            ),
      ));
      
      mapController.addMarker(MarkerOptions(
        position: LatLng(widget.lat, widget.lng),
        draggable: true,
        infoWindowText: InfoWindowText(widget.city, widget.address),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
}
