import 'dart:convert';

import 'package:location/location.dart';
import 'package:prixz_techical_test/commons/error/exceptions.dart';
import 'package:prixz_techical_test/commons/utils/kml_parser.dart';
import 'package:prixz_techical_test/features/location_tracker/data/model/location_model.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/entity/kml_placemark_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocationLocalDataSource {
  Future<LocationModel> getLastKnowLocation();

  Future<LocationData> getLocation();

  Future<List<KmlPlacemark>> getGeofences();

  Future<void> cacheLastKnowLocation(LocationModel locationToCache);
}

const CACHED_LAST_KNOW_LOCATION = 'CACHED_LAST_KNOW_LOCATION';

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  final SharedPreferences sharedPreferences;
  final Kml kmlParser;
  final Location locationService;

  LocationLocalDataSourceImpl(
      {this.sharedPreferences, this.locationService, this.kmlParser});

  @override
  Future<LocationData> getLocation() async {
    LocationData currentPosition;
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationService.requestService();
      if (!serviceEnabled) {
        throw LocationServiceException();
      }
    }

    permissionGranted = await locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw LocationPermissionsException();
      }
    }
    currentPosition = await locationService.getLocation();
    return currentPosition;
  }

  @override
  Future<LocationModel> getLastKnowLocation() {
    final jsonString = sharedPreferences.getString(CACHED_LAST_KNOW_LOCATION);
    if (jsonString != null) {
      var location = LocationModel.fromJson(json.decode(jsonString));
      return Future.value(location);
    } else {
      return null;
    }
  }

  @override
  Future<void> cacheLastKnowLocation(LocationModel locationToCache) {
    return sharedPreferences.setString(
      CACHED_LAST_KNOW_LOCATION,
      json.encode(locationToCache.toJson()),
    );
  }

  @override
  Future<List<KmlPlacemark>> getGeofences() async {
    final geofence = await kmlParser.parseKML();
    if (geofence != null) {
      return Future.value(geofence);
    }
  }
}
