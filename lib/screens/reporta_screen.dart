import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String _incidentDescription = '';

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
          ],
        ),
      ),
    );
  }
}