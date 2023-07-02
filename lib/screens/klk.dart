// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class EmpoderateScreen extends StatefulWidget {
//   @override
//   _EmpoderateScreenState createState() => _EmpoderateScreenState();
// }

// class _EmpoderateScreenState extends State<EmpoderateScreen> {
//   List<Map<String, dynamic>> messages = [];
//   TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat de Ayuda'),
//         backgroundColor: Color(0xff5C4DB1),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 bool isUserMessage = messages[index]['isUserMessage'];
//                 return ListTile(
//                   title: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isUserMessage
//                           ? Color(0xff5C4DB1)
//                           : Color(0xffDFDEFF),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       messages[index]['message'],
//                       style: TextStyle(
//                         color: isUserMessage ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                   leading: isUserMessage ? null : Icon(Icons.assistant),
//                   trailing: isUserMessage ? Icon(Icons.person) : null,
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 suffixIcon: IconButton(
//                   onPressed: _sendMessage,
//                   icon: Icon(Icons.send),
//                   color: Color(0xff5C4DB1),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _sendMessage() async {
//     String message = _controller.text;
//     _controller.clear();
//     setState(() {
//       messages.add({'message': message, 'isUserMessage': true});
//     });

//     String url = 'https://api.openai.com/v1/chat/completions';
//     var response = await http.post(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer <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>',
//       },
//       body: json.encode({
//         'prompt': message,
//       }),
//     );

//     if (response.statusCode == 200) {
//       String serverMessage = json.decode(response.body)['choices'][0]['text'];
//       setState(() {
//         messages.add({'message': serverMessage, 'isUserMessage': false});
//       });
//     }
//   }
// }

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



// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class EmergencyScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff5C4DB1),
//       appBar: AppBar(
//         elevation: 0,
//         title: Text('Emergencia'),
//         backgroundColor: Color(0xff5C4DB1),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Column(
//         children: [
//           Flexible(
//             child: Container(
//               height: 500,
//               child: GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(-33.8567844, 151.213108),
//                   zoom: 15,
//                 ),
//                 polylines: {},
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.only(top: 20, left: 15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Color(0xff5C4DB1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                         size: 35,
//                       ),
//                     ),
//                     title: Container(
//                       margin: EdgeInsets.only(left: 10),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Name:',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Text(
//                             'John Doe',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                     leading: Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Color(0xff5C4DB1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.home,
//                         color: Colors.white,
//                         size: 35,
//                       ),
//                     ),
//                     title: Container(
//                       margin: EdgeInsets.only(left: 10),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Address:',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Text(
//                             '123 Main St',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                     leading: Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Color(0xff5C4DB1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.category,
//                         color: Colors.white,
//                         size: 35,
//                       ),
//                     ),
//                     title: Container(
//                       margin: EdgeInsets.only(left: 10),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Type:',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Text(
//                             'Personal',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:protegelapp/emergency_settings/constans.dart';

// class EmergencyScreen extends StatefulWidget {
//   const EmergencyScreen({Key? key}) : super(key: key);

//   @override
//   State<EmergencyScreen> createState() => _EmergencyScreenState();
// }

// class _EmergencyScreenState extends State<EmergencyScreen> {
//   final Completer<GoogleMapController> _controller = Completer();

//   static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
//   static const LatLng destination = LatLng(37.3342099383, -122.06600055);

//   List<LatLng> polylineCoordinates = [];
//   Set<Polyline> polylines = {};

//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

//   @override
//   void initState() {
//     super.initState();
//     setCustomMarkerIcon();
//     getPolylineCoordinates();
//   }

//   void setCustomMarkerIcon() async {
//     sourceIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration.empty,
//       "images/Logo.png",
//     );
//     destinationIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration.empty,
//       "images/Logo.png",
//     );
//     currentLocationIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration.empty,
//       "images/banner.png",
//     );
//     setState(() {});
//   }

//   void getPolylineCoordinates() async {
//     PolylinePoints polylinePoints = PolylinePoints();

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       google_api_key,
//       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });

//       setState(() {
//         polylines.add(Polyline(
//           polylineId: PolylineId("route"),
//           color: primaryColor,
//           width: 6,
//           points: polylineCoordinates,
//         ));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Color(0xff5C4DB1),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: sourceLocation,
//           zoom: 13.5,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId("currentLocation"),
//             icon: currentLocationIcon,
//             position: sourceLocation,
//           ),
//           Marker(
//             markerId: MarkerId("destination"),
//             icon: destinationIcon,
//             position: destination,
//           ),
//         },
//         polylines: polylines,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }

