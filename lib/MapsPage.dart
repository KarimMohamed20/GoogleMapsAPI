import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsDemo extends StatefulWidget {
  final double lat;
  final double lng;
  MapsDemo(
      {@required this.lat,
      @required this.lng,});
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
            zoom: 2.0,
            tilt: 30.0,
            ),
      ));
      
      mapController.addMarker(MarkerOptions(
        position: LatLng(66.02219,12.63376),
        draggable: true,
        infoWindowText: InfoWindowText('Helgelandskysten','Helgelandskysten'),
        icon: BitmapDescriptor.defaultMarker,
      ));
      mapController.addMarker(MarkerOptions(
        position: LatLng(68.03515,16.50279, ),
        draggable: true,
        infoWindowText: InfoWindowText('Tysfjord','Tysfjord'),
        icon: BitmapDescriptor.defaultMarker,
      ));
      mapController.addMarker(MarkerOptions(
        position: LatLng(60.08929,7.53744),
        draggable: true,
        infoWindowText: InfoWindowText('Sledehunds-ekspedisjon','Sledehunds-ekspedisjon'),
        icon: BitmapDescriptor.defaultMarker,
      ));
      mapController.addMarker(MarkerOptions(
        position: LatLng(62.57481, 11.38411),
        draggable: true,
        infoWindowText: InfoWindowText('Amundsens sydpolferd','Amundsens sydpolferd'),
        icon: BitmapDescriptor.defaultMarker,
      ));
      mapController.addMarker(MarkerOptions(
        position: LatLng(60.96335, 6.96781),
        draggable: true,
        infoWindowText: InfoWindowText('Vikingtokt','Vikingtokt'),
        icon: BitmapDescriptor.defaultMarker,
      ));
      mapController.addMarker(MarkerOptions(
        position: LatLng(59.87111,8.49139),
        draggable: true,
        infoWindowText: InfoWindowText('Tungtvann- sabotasjen','Tungtvann- sabotasjen'),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
}
