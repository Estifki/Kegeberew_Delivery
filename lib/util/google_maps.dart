
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class GoogleMapsFullScreen extends StatefulWidget {
  final double sourceLat;

  final double sourceLong;

  final double destinationLat;

  final double destinationLong;
  const GoogleMapsFullScreen(
      {super.key,
      required this.sourceLat,
      required this.sourceLong,
      required this.destinationLat,
      required this.destinationLong});
  @override
  State<GoogleMapsFullScreen> createState() => _GoogleMapsFullScreenState();
}

class _GoogleMapsFullScreenState extends State<GoogleMapsFullScreen> {
  List<LatLng> polyLineCoordinate = [];

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDXGVyh9MTUKU38syRDuzyWD0SBmUFkp2M",
        PointLatLng(widget.sourceLat, widget.sourceLong),
        PointLatLng(widget.destinationLat, widget.destinationLong));
    if (result.points.isNotEmpty) {
      for (var points in result.points) {
        polyLineCoordinate.add(LatLng(points.latitude, points.longitude));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      indoorViewEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.sourceLat, widget.sourceLong), zoom: 13),
      markers: {
        Marker(
            markerId: const MarkerId("source"),
            position: LatLng(widget.sourceLat, widget.sourceLong)),
        Marker(
            markerId: const MarkerId("destination"),
            position: LatLng(widget.destinationLat, widget.destinationLong)),
      },
      polylines: {
        Polyline(
            polylineId: const PolylineId("Route"),
            points: polyLineCoordinate,
            color: Colors.red.shade300,
            width: 5)
      },
    );
  }
}
