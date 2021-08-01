import 'package:geocoder/geocoder.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:prixz_techical_test/features/location_tracker/data/data_source/location_local_data_source.dart';
import 'package:prixz_techical_test/features/location_tracker/data/data_source/location_remote_data_source.dart';
import 'package:prixz_techical_test/features/location_tracker/data/repository/location_repository_impl.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/repository/location_repository.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/use_case/set_location_use_case.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/use_case/user_location_use_case.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'commons/utils/kml_parser.dart';
import 'features/location_tracker/presentation/bloc/loader_cubit/loader_cubit.dart';

final locator = GetIt.instance;

Future<void> setUpDI() async {
  // Bloc
  locator.registerFactory(
    () => LoaderCubit(),
  );

  locator.registerFactory(
    () => LocationCubit(
      getUserLocationUseCase: locator(),
      setUserLocationUseCase: locator(),
      loaderCubit: locator(),
    ),
  );

  // Use cases
  locator.registerLazySingleton(
    () => GetUserLocationUseCase(locationRepository: locator()),
  );
  locator.registerLazySingleton(
    () => SetUserLocationUseCase(locationRepository: locator()),
  );

  // Repository
  locator.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      locationLocalDataSource: locator(),
      locationRemoteDataSource: locator(),
    ),
  );

  // Data sources
  locator.registerLazySingleton<LocationLocalDataSource>(
    () => LocationLocalDataSourceImpl(
        sharedPreferences: locator(),
        locationService: locator(),
        kmlParser: locator()),
  );

  locator.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(
      geocoder: locator(),
    ),
  );

  //Core
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => Location());
  locator.registerLazySingleton(() => Kml());
  locator.registerLazySingleton(() => Geocoder.local);
}
