import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes'),
        backgroundColor: Color(0xff5C4DB1),
      ),
      body: Center(
        child: Text('Pantalla de reportes'),
      ),
    );
  }
}