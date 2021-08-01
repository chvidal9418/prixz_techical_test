
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationRemoteDataSource{

  Future<List<Address>> getAddress(LatLng latLng);
  Future<String> getAddressFromQuery(String query);

}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource{

  final Geocoding geocoder;

  LocationRemoteDataSourceImpl({this.geocoder});

  @override
  Future<List<Address>> getAddress(LatLng latLng) {
    final coordinates = new Coordinates(latLng.latitude,latLng.longitude);
    return geocoder.findAddressesFromCoordinates(coordinates);
  }

  @override
  Future<String> getAddressFromQuery(String query) {
    // TODO: implement getAddressFromQuery
    throw UnimplementedError();
  }
}