import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/widget/loader_widget.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/widget/gps_location_tracker.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/widget/map_location_tracker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int actualIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildHeader(context),
              buildPrincipalContainer(),
              buildOptionPicker(context),
            ],
          ),
        ),
      ),
    );
  }

  Flexible buildPrincipalContainer() {
    return Flexible(
      child: FractionallySizedBox(
        child: IndexedStack(
          index: actualIndex,
          children: [
            GpsLocationTracker(),
            MapLocationTracker(),
          ],
        ),
      ),
    );
  }

  BlocBuilder buildHeader(BuildContext context) {
    final locationCubit = BlocProvider.of<LocationCubit>(context);
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (BuildContext context, LocationState state) {
        var zone = 'Fuera de Zona';
        var title = 'Ubicacion Desconocida';
        var subtitle = '';

        if (state is LocationInitial) {
          locationCubit.retrieveUserLocation(getFromCache: true);
        }

        if (state is LocationLoaded) {
          zone = state.locationEntity.geofenceName;
          title = state.locationEntity.address;

          final acquirementDate = state.locationEntity.acquirementDate;
          subtitle = '${acquirementDate.toLocal()}';
        }

        return Container(
          height: MediaQuery.of(context).size.height / 6,
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: LoaderWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Text(
                      '${zone}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Obtenida por ultima vez ${subtitle}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container buildOptionPicker(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildExpanded(0, Icons.add_location),
          buildExpanded(1, Icons.map),
        ],
      ),
    );
  }

  Expanded buildExpanded(int index, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: () {
              setState(() => actualIndex = index);
            },
          ),
          if (actualIndex == index)
            ClipOval(
              child: Material(
                color: Colors.indigo, // button color
                child: SizedBox(
                  width: 4,
                  height: 4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
