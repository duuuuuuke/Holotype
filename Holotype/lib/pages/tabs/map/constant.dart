import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

/**********************************************************************
*    Title: Flutter MapBox Integration: Complete Guide with Example
*    Author: Dhruv Nakum
*    Date: 2022
*    Availability: https://dhruvnakum.xyz/flutter-mapbox-integration-complete-guide-with-example
*
**********************************************************************/
class AppConstants {
  static const String mapBoxAccessToken =
      'pk.eyJ1IjoiZHVrZWJhaSIsImEiOiJjbDk0emdqcWgwMXozM3pvMXowMGs2NjZrIn0.3YIHtn4G2LsTy3ifqBUSVw';

  static const String mapBoxStyleId = 'cl95lh8b1000514o2vaknw2eo';

  static final myLocation = LatLng(-27.49741805, 153.01316955983583);

  static final offlineTestLocation =
      LatLng(-26.16529889631604, 129.166259765625);
}
