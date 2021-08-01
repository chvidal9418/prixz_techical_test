import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prixz_techical_test/features/location_tracker/data/model/location_model.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/entity/kml_placemark_entity.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/entity/location_entity.dart';

abstract class LocationRepository {

  Future<LocationData> getLocation();

  Future<LocationEntity> getLastKnowLocation();

  Future<List<Address>> getAddress(LatLng latLng);

  Future<void> cacheLastKnowLocation(LocationModel locationToCache);

  Future<List<KmlPlacemark>> getGeofences();

}
