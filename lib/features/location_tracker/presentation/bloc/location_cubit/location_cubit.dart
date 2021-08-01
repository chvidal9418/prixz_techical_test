import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:prixz_techical_test/features/location_tracker/data/model/location_model.dart';
import 'package:prixz_techical_test/features/location_tracker/data/model/params/current_location_params.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/use_case/set_location_use_case.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/use_case/user_location_use_case.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/bloc/loader_cubit/loader_cubit.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({
    this.getUserLocationUseCase,
    this.setUserLocationUseCase,
    this.loaderCubit,
  }) : super(LocationInitial());

  final GetUserLocationUseCase getUserLocationUseCase;
  final SetUserLocationUseCase setUserLocationUseCase;
  final LoaderCubit loaderCubit;

  Future<void> retrieveUserLocation({bool getFromCache}) async {
    loaderCubit.toggleLoader(true);

    final userLocation = await getUserLocationUseCase
        .call(CurrentLocationParams(getFromCache: getFromCache));

    loaderCubit.toggleLoader(false);

    emit(LocationLoaded(userLocation));

  }

  Future<void> setUserLocation(LatLng latLng) async {
    loaderCubit.toggleLoader(true);

    final userLocation = await setUserLocationUseCase
        .call(CurrentLocationParams(latLng: latLng));
    loaderCubit.toggleLoader(false);

    emit(LocationLoaded(userLocation));
  }
}
