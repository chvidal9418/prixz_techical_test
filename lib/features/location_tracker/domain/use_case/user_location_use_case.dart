import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prixz_techical_test/commons/core/use_case.dart';
import 'package:prixz_techical_test/commons/utils/kml_parser.dart';
import 'package:prixz_techical_test/features/location_tracker/data/model/location_model.dart';
import 'package:prixz_techical_test/features/location_tracker/data/model/params/current_location_params.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/repository/location_repository.dart';

class GetUserLocationUseCase
    implements UseCase<LocationModel, CurrentLocationParams> {
  final LocationRepository locationRepository;

  GetUserLocationUseCase({this.locationRepository});

  @override
  Future<LocationModel> call(CurrentLocationParams params) async {
    final cachedLocation = await locationRepository.getLastKnowLocation();

    if (cachedLocation != null && params.getFromCache) {
      return cachedLocation;
    }

    final location = await locationRepository.getLocation();
    final LatLng latLng = LatLng(location.latitude, location.longitude);
    final addressList = await locationRepository.getAddress(latLng);

    final geofences = await locationRepository.getGeofences();
    final geofenceName = Kml.geofencesName(
        geofences, LatLng(location.latitude, location.longitude));

    final actualLocation = LocationModel(
      latLng: latLng,
      address: addressList.first.addressLine,
      acquirementDate: DateTime.now(),
      isCached: false,
      geofenceName: geofenceName,
    );

    await locationRepository.cacheLastKnowLocation(actualLocation);

    return actualLocation;
  }
}
