import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationEntity {
  final LatLng latLng;
  final String address;
  final DateTime acquirementDate;

  LocationEntity(this.latLng, this.address, this.acquirementDate);
}
