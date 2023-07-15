import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};
  final LatLng _initialPosition = const LatLng(37.42796133580664, -122.085749655962);
  LatLng? _selectedPosition;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('id-1'),
          position: _initialPosition,
          infoWindow: InfoWindow(
            title: 'Stanford University',
            snippet: 'Graduate School of Business',
          ),
        ),
      );
    });
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedPosition = position;
      _markers.add(
        Marker(
          markerId: MarkerId('id-2'),
          position: position,
        ),
      );
    });
  }

  void _onSubmit() {
    if (_selectedPosition != null) {
      // Enviar la información al servidor o guardarla en la base de datos local
      print('Ubicación seleccionada: $_selectedPosition');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Maps')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onTap: _onMapTapped,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSubmit,
        child: Icon(Icons.send),
      ),
    );
  }
}