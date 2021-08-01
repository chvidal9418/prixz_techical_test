import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/widget/animated_marker.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/widget/location_picker.dart';

class MapLocationTracker extends StatelessWidget {
  const MapLocationTracker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationCubit = BlocProvider.of<LocationCubit>(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
                child: Stack(
                  children: [
                    LocationPicker(
                      onLocationChangeHandler: (LatLng latLng){
                        notificationCubit.setUserLocation(latLng);
                      },
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: AnimatedMarker(
                        size: MediaQuery.of(context).size.width / 8,
                        isMoving: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void locationHandler(LatLng latLng) {
    print('Llego ${latLng.toString()}');
  }
}
