import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:chatify/services/geolocator_service.dart';


class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();


  //Variables
  Position currentLocation;

  ApplicationBloc() {
    setCurrentLocation();
  }


  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}