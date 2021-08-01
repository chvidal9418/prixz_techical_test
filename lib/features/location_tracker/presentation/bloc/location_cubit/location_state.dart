part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationModel locationEntity;

  LocationLoaded(this.locationEntity);
}

class LocationError extends LocationState {
  final LocationModel locationEntity;

  LocationError(this.locationEntity);
}
