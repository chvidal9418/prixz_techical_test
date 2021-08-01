import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/entity/location_entity.dart';

class LocationModel extends LocationEntity {
  final bool isCached;
  final String geofenceName;
  LocationModel({
    LatLng latLng,
    String address,
    DateTime acquirementDate,
    this.isCached,
    this.geofenceName='',
  }) : super(latLng, address, acquirementDate);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latLng: LatLng.fromJson(json['latLng']),
      address: json['address'],
      acquirementDate: DateTime.parse(json['acquirementDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latLng': latLng.toJson(),
      'address': address,
      'acquirementDate': acquirementDate.toIso8601String(),
    };
  }
}
