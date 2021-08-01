import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

typedef LatLngHandler(LatLng latLng);

class LocationPicker extends StatefulWidget {
  final LatLngHandler onLocationChangeHandler;

  const LocationPicker({Key key, this.onLocationChangeHandler})
      : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController mapController;
  LatLng cameraPosition = LatLng(19.307877, -99.2126347);
  String mapStyle;

  @override
  void initState() {
    super.initState();
    configMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: cameraPosition,
        zoom: 15,
      ),
      mapType: MapType.normal,
      onMapCreated: onMapCreated,
      zoomControlsEnabled: false,
      onCameraMove: cameraMoveHandler,
      onCameraIdle: cameraIdleHandler,
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(mapStyle);
  }

  void moveCamera(LatLng latLng) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 15,
        ),
      ),
    );
  }

  void cameraMoveHandler(CameraPosition position) {
    setState(() => cameraPosition = position.target);
  }

  void cameraIdleHandler() {
    widget.onLocationChangeHandler(cameraPosition);
  }

  void configMapStyle() async {

    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });
  }
}
