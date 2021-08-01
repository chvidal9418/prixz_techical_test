import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:maps_toolkit/maps_toolkit.dart' as MapsToolkit;
import 'package:prixz_techical_test/features/location_tracker/domain/entity/kml_placemark_entity.dart';
import 'package:xml/xml.dart';

class Kml {
  Future<List<KmlPlacemark>> parseKML() async {
    final data = await rootBundle.loadString('assets/area.kml');

    final kmlDocument = XmlDocument.parse(data).rootElement;

    if (kmlDocument.name.toString() != 'kml') {
      throw ("ERROR: the file is not a KML compatible file");
    }

    List<KmlPlacemark> placemarkList = [];

    kmlDocument.findAllElements("Placemark").forEach((placemark) {
      List<LatLng> points = [];

      String name = placemark.getElement('name').text;

      final coordinates =
          placemark.findAllElements('coordinates').first.text.trim().split(' ');

      coordinates.forEach((latLng) {
        final coordinates = latLng.toString().split(",");
        if (coordinates.length >= 2) {
          double lat = double.parse(coordinates[1]);
          double lng = double.parse(coordinates[0]);
          points.add(LatLng(lat, lng));
        }
      });

      placemarkList.add(
        KmlPlacemark(
          name: name,
          coordinates: points,
        ),
      );
    });

    return placemarkList;
  }

  static String geofencesName(List<KmlPlacemark> geofences, LatLng location) {
    String area = 'Fuera de zona';

    geofences.forEach((element) {
      MapsToolkit.LatLng latLng =
          MapsToolkit.LatLng(location.latitude, location.longitude);

      final latLngList = element.coordinates
          .map((e) => MapsToolkit.LatLng(e.latitude, e.longitude));

      if (MapsToolkit.PolygonUtil.containsLocation(
          latLng, latLngList.toList(), true))
        area = element.name;
    });

    return area;
  }
}
