import 'dart:async';
import 'dart:collection';
import 'package:chatify/blocs/application_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Circle> _circles = HashSet<Circle>();
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _setCircles();
    storeUserLocation();

    Firestore.instance.collection('users').snapshots().listen((event) {
      event.documentChanges.forEach((change) {
        setState(() {
          markers.add(Marker(
              markerId: MarkerId(change.document.documentID),
              infoWindow:
                  InfoWindow(title: change.document.data['name'].toString()),
              position: LatLng(change.document.data['location'].latitude,
                  change.document.data['location'].longitude)));
        });
      });
    });
  }

  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(37.76493, -122.42432),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(153, 51, 51, 0.7098039215686275)),
    );
  }

  GoogleMapController mapController;
  LatLng currentLocation;

  @override
  Widget build(BuildContext context) {
     final applicationBloc = Provider.of<ApplicationBloc>(context);

    void onMapCreated(controller) {
      setState(() {
        mapController = controller;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Map',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: (applicationBloc.currentLocation == null)
          ? Center(
        child: CircularProgressIndicator(),
      ): Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  applicationBloc.currentLocation.latitude,
                  applicationBloc.currentLocation.longitude),
              zoom: 12,
            ),
            circles: _circles,
            myLocationEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            mapToolbarEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers.toSet(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.coronavirus_sharp),
        onPressed: () {
          dialog(context);
        },
      ),
    );
  }
}

storeUserLocation() {
  Location location = new Location();

  location.onLocationChanged.listen((LocationData currentLocation) {
    Firestore.instance
        .collection('Users')
        .document('2ZeiLAmfho8ABJOCUkSl')
        .setData({
      'name': 'Crona',
      'location': GeoPoint(currentLocation.latitude, currentLocation.longitude)
    });
  });
}

void dialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text("Do you infected Covid-19 ?"),
        content: Text(
            "If you click on yes, we will follow up for you and display the last five days you were with them."),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: MaterialButton(
              shape: StadiumBorder(),
              minWidth: 100,
              color: Colors.blue,
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          MaterialButton(
            shape: StadiumBorder(),
            minWidth: 100,
            color: Colors.blueAccent,
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
