import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prixz_techical_test/features/location_tracker/data/data_source/location_local_data_source.dart';
import 'package:prixz_techical_test/features/location_tracker/data/data_source/location_remote_data_source.dart';
import 'package:prixz_techical_test/features/location_tracker/data/model/location_model.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/entity/kml_placemark_entity.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/repository/location_repository.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationLocalDataSource locationLocalDataSource;
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl(
      {this.locationLocalDataSource, this.locationRemoteDataSource});

  @override
  Future<List<Address>> getAddress(LatLng latLng) async {
    return await locationRemoteDataSource.getAddress(latLng);
  }

  @override
  Future<LocationData> getLocation() async {
    return await locationLocalDataSource.getLocation();
  }

  @override
  Future<LocationModel> getLastKnowLocation() async {
    return await locationLocalDataSource.getLastKnowLocation();
  }

  @override
  Future<void> cacheLastKnowLocation(LocationModel locationToCache) async {
    return await locationLocalDataSource.cacheLastKnowLocation(locationToCache);
  }

  @override
  Future<List<KmlPlacemark>> getGeofences() async {
    return await locationLocalDataSource.getGeofences();
  }
}
