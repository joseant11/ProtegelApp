import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String _incidentDescription = '';
  String? _selectedAggression;
  final List<String> _aggressions = [
    'Agresión física',
    'Agresión sexual',
    'Agresión verbal',
    'Agresión psicológica',
    'Agresión digital',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes'),
        backgroundColor: Color(0xff5C4DB1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff5C4DB1)),
                ),
                labelText: 'Descripción del incidente',
                labelStyle: TextStyle(color: Color(0xff5C4DB1), fontSize: 18.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff5C4DB1)),
                ),
              ),
              onChanged: (value) => _incidentDescription = value,
            ),
            SizedBox(height: 16.0),
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Tipo de agresión',
                labelStyle: TextStyle(color: Color(0xff5C4DB1), fontSize: 18.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff5C4DB1)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedAggression,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedAggression = newValue;
                    });
                  },
                  items:
                      _aggressions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}