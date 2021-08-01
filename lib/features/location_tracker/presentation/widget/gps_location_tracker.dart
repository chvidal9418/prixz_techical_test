import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/bloc/location_cubit/location_cubit.dart';

class GpsLocationTracker extends StatelessWidget {
  const GpsLocationTracker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationCubit = BlocProvider.of<LocationCubit>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: IconButton(
              color: Colors.grey,
              icon: Icon(Icons.gps_fixed),
              iconSize: MediaQuery.of(context).size.height / 3,
              onPressed: () {
                notificationCubit.retrieveUserLocation(getFromCache: false);
              },
            ),
          ),
          Text('Presiona para obtener la ubicacion desde el GPS')
        ],
      ),
    );
  }

  void locationHandler(LatLng latLng) {
    print('Llego ${latLng.toString()}');
  }

  void listener(BuildContext context, bool state) {
    print('Llego ${state}');
  }
}
