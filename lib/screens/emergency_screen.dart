import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class EmergencyScreen extends StatefulWidget {
  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
} 


class _EmergencyScreenState extends State<EmergencyScreen> {
  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-33.8567844, 151.213108),
    zoom: 15,
  );

   Set<Polyline> _polylines = {};

  Future<List<LatLng>> _getRouteCoordinates(LatLng origin, LatLng destination) async {
    String apiKey = 'AIzaSyBwXBro9MaEREqtNiBp8po6bZVka2NG8U8';
    String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> steps = jsonResponse['routes'][0]['legs'][0]['steps'];
      List<LatLng> routeCoordinates = [];

      for (Map<String, dynamic> step in steps) {
        String polylinePoints = step['polyline']['points'];
        List<LatLng> decodedPoints = _decodePolyline(polylinePoints);

        routeCoordinates.addAll(decodedPoints);
      }

      return routeCoordinates;
    } else {
      throw Exception('Failed to fetch route coordinates');
    }
  }
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = LatLng((lat / 1E5), (lng / 1E5));
      points.add(p);
    }

    return points;
  }

    Future<void> _showRoute(LatLng origin, LatLng destination) async {
    List<LatLng> routeCoordinates = await _getRouteCoordinates(origin, destination);

    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId('route'),
        points: routeCoordinates,
        color: Colors.red,
        width: 5,
      ));
    });
  }

 

    @override
  void initState() {
    super.initState();
    LatLng origin = LatLng(-33.8567844, 151.213108); // Coordenadas de origen
    LatLng destination = LatLng(-33.865143, 151.209900); // Coordenadas de destino
    _showRoute(origin, destination); // Llama al método _showRoute
  }



  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Color(0xff5C4DB1),
        appBar: AppBar(
          //elevation: 0,
          backgroundColor: Color(0xff5C4DB1),      
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Expanded(
                    child: Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 18 / 9,
                              child: GoogleMap(
                                initialCameraPosition: _initialPosition,
                                mapType: MapType.normal,
                                myLocationEnabled: true,
                                zoomGesturesEnabled: true,
                                polylines: _polylines,
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            color: Color(0xff5C4DB1),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 20),
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
                          leading: Material(
                            child: Container(
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
                          ),
                          title: Material(
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          trailing: Material(
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          ),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ProfileScreen(),
                            //   ),
                            // );
                          },
                        ),
    
                      //   SizedBox(height: 20),
                      //   ListTile(
                      //     leading: Container(
                      //       padding: EdgeInsets.all(10),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xff5C4DB1),
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: Icon(
                      //         Icons.notifications_none_rounded,
                      //         color: Colors.white,
                      //         size: 35,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       'Notifications',
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     trailing: Icon(
                      //       Icons.arrow_forward_ios_rounded,
                      //       size: 20,
                      //     ),
                      //     onTap: () {
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //     builder: (context) => ProfileScreen(),
                      //       //   ),
                      //       // );
                      //     },
                      //   ),
                      //   SizedBox(height: 20),
                      //   ListTile(
                      //     leading: Container(
                      //       padding: EdgeInsets.all(10),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xff5C4DB1),
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: Icon(
                      //         Icons.privacy_tip_rounded,
                      //         color: Colors.white,
                      //         size: 35,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       'Privacy',
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     trailing: Icon(
                      //       Icons.arrow_forward_ios_rounded,
                      //       size: 20,
                      //     ),
                      //     onTap: () {
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //     builder: (context) => ProfileScreen(),
                      //       //   ),
                      //       // );
                      //     },
                      //   ),
                      //   SizedBox(height: 20),
                      //   ListTile(
                      //     leading: Container(
                      //       padding: EdgeInsets.all(10),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xff5C4DB1),
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: Icon(
                      //         Icons.settings_outlined,
                      //         color: Colors.white,
                      //         size: 35,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       'General',
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     trailing: Icon(
                      //       Icons.arrow_forward_ios_rounded,
                      //       size: 20,
                      //     ),
                      //     onTap: () {
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //     builder: (context) => ProfileScreen(),
                      //       //   ),
                      //       // );
                      //     },
                      //   ),
                      //   SizedBox(height: 20),
                      //   ListTile(
                      //     leading: Container(
                      //       padding: EdgeInsets.all(10),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xff5C4DB1),
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: Icon(
                      //         Icons.info_outline_rounded,
                      //         color: Colors.white,
                      //         size: 35,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       'About Us',
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     trailing: Icon(
                      //       Icons.arrow_forward_ios_rounded,
                      //       size: 20,
                      //     ),
                      //     onTap: () {
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //     builder: (context) => ProfileScreen(),
                      //       //   ),
                      //       // );
                      //     },
                      //   ),
                      //   Divider(height: 40),
                      //   ListTile(
                      //     leading: Container(
                      //       padding: EdgeInsets.all(10),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xff5C4DB1),
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: Icon(
                      //         Icons.logout,
                      //         color: Colors.white,
                      //         size: 35,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       'Log Out',
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     trailing: Icon(
                      //       Icons.arrow_forward_ios_rounded,
                      //       size: 20,
                      //     ),
                      //     onTap: () {
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //     builder: (context) => ProfileScreen(),
                      //       //   ),
                      //       // );
                      //   },
                      //  ),
                      ],
                     ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

