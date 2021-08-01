import 'package:google_maps_flutter/google_maps_flutter.dart';

class KmlPlacemark {
  String name;
  String altitudeMode;
  List<LatLng> coordinates;
  bool valid;

  KmlPlacemark({
    this.name,
    this.altitudeMode,
    this.coordinates,
    this.valid = true,
  });
}