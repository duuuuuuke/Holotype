import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
/**********************************************************************
*    Title: Flutter MapBox Integration: Complete Guide with Example
*    Author: Dhruv Nakum
*    Date: 2022
*    Availability: https://dhruvnakum.xyz/flutter-mapbox-integration-complete-guide-with-example
*
**********************************************************************/

class MapMarker {
  final Image? image;
  final String? title;
  final String? description;
  final LatLng? location;

  MapMarker({
    required this.image,
    required this.title,
    required this.description,
    required this.location,
  });
}
