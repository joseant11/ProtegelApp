// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class EmergencyScreen extends StatefulWidget {
//   @override
//   _EmergencyScreenState createState() => _EmergencyScreenState();
// }

// class _EmergencyScreenState extends State<EmergencyScreen> {
//   static final CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(-33.8567844, 151.213108),
//     zoom: 15,
//   );

//   Set<Polyline> _polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     _showRoute();
//   }

//   Future<void> _showRoute() async {
//     LatLng origin = LatLng(-33.8567844, 151.213108); // Coordenadas de origen
//     LatLng destination = LatLng(-33.865143, 151.209900); // Coordenadas de destino
//     List<LatLng> routeCoordinates = await _getRouteCoordinates(origin, destination);

//     setState(() {
//       _polylines.add(Polyline(
//         polylineId: PolylineId('route'),
//         points: routeCoordinates,
//         color: Colors.red,
//         width: 5,
//       ));
//     });
//   }

//   Future<List<LatLng>> _getRouteCoordinates(LatLng origin, LatLng destination) async {
//     String apiKey = 'AIzaSyBwXBro9MaEREqtNiBp8po6bZVka2NG8U8';
//     String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';
//     http.Response response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//       List<dynamic> steps = jsonResponse['routes'][0]['legs'][0]['steps'];
//       List<LatLng> routeCoordinates = [];

//       for (Map<String, dynamic> step in steps) {
//         String polylinePoints = step['polyline']['points'];
//         List<LatLng> decodedPoints = _decodePolyline(polylinePoints);

//         routeCoordinates.addAll(decodedPoints);
//       }

//       return routeCoordinates;
//     } else {
//       throw Exception('Failed to fetch route coordinates');
//     }
//   }

//   List<LatLng> _decodePolyline(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;

//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;

//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;

//       LatLng p = LatLng((lat / 1E5), (lng / 1E5));
//       points.add(p);
//     }

//     return points;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Emergency Screen'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: _initialPosition,
//         polylines: _polylines,
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5C4DB1),
      appBar: AppBar(
        elevation: 0,
        title: Text('Emergencia'),
        backgroundColor: Color(0xff5C4DB1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              height: 500,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(-33.8567844, 151.213108),
                  zoom: 15,
                ),
                polylines: {},
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20, left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff5C4DB1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    title: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            'Name:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff5C4DB1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    title: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            'Address:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '123 Main St',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff5C4DB1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.category,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    title: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            'Type:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Personal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



