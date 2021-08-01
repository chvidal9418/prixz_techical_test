import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationParams{
  final bool getFromCache;
  final LatLng latLng;

  CurrentLocationParams({this.getFromCache=true,this.latLng});
}