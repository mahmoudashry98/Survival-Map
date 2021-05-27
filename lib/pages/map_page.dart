import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  String searchAddr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Map',
          style:TextStyle(
              color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20
          ),
        ),
        centerTitle: true,),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.77483, -122.41942),
              zoom: 12,
            ),
            circles: _circles,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers.toSet(),
          ),
          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: searchandNavigate,
                        iconSize: 30.0)),
                onChanged: (val) {
                  setState(() {
                    searchAddr = val;
                  });
                },
              ),
            ),
          )
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

  searchandNavigate() {
    // Geolocator().placemarkFromAddress(searchAddr).then((result) {
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //       target:
    //       LatLng(result[0].position.latitude, result[0].position.longitude),
    //       zoom: 10.0)));
    // });
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
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
