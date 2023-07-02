import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:protegelapp/emergency_settings/constans.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.3342099383, -122.06600055);

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setCustomMarkerIcon();
    getPolylineCoordinates();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void setCustomMarkerIcon() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "images/Logo.png",
    );
    destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "images/Logo.png",
    );
    currentLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "images/banner.png",
    );
    setState(() {});
  }

  void getPolylineCoordinates() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        polylines.add(Polyline(
          polylineId: PolylineId("route"),
          color: primaryColor,
          width: 6,
          points: polylineCoordinates,
        ));
      });
    }
  }

  void startTimer() {
    const duration = Duration(milliseconds: 1000);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (_currentIndex < polylineCoordinates.length) {
        setState(() {
          _currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff5C4DB1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: sourceLocation,
          zoom: 13.5,
        ),
        markers: {
          Marker(
            markerId: MarkerId("currentLocation"),
            icon: currentLocationIcon,
            position: _currentIndex > 0
                ? polylineCoordinates[_currentIndex - 1]
                : sourceLocation,
          ),
          Marker(
            markerId: MarkerId("source"),
            icon: sourceIcon,
            position: sourceLocation,
          ),
          Marker(
            markerId: MarkerId("destination"),
            icon: destinationIcon,
            position: destination,
          ),
        },
        polylines: polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
