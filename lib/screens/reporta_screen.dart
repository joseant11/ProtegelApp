import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:protegelapp/screens/mapscreen.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String _userName = '';
  String _userId = '';
  String _userEmail = '';
  String _userPhone = '';

  String? _nameError;
  String? _idError;
  String? _emailError;
  String? _phoneError;
  String _incidentDescription = '';
  DateTime? _selectedDateTime;
  LatLng? _selectedLocation;

  bool validate() {
    bool isValid = true;

    // Validar el nombre
    if (_userName.isEmpty) {
      _nameError = 'El nombre es obligatorio';
      isValid = false;
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(_userName)) {
      _nameError = 'El nombre solo puede contener letras';
      isValid = false;
    }

    // Validar la cédula
    if (_userId.length != 11) {
      _idError = 'La cédula debe tener 11 dígitos';
      isValid = false;
    }

    // Validar el correo electrónico
    if (!_userEmail.contains('@')) {
      _emailError = 'Correo electrónico inválido';
      isValid = false;
    }

    // Validar el número de teléfono
    if (_userPhone.length != 10) {
      _phoneError = 'El número de teléfono debe tener 10 dígitos';
      isValid = false;
    }

    return isValid;
  }

  String? _selectedAggression;
  final List<String> _aggressions = [
    'Agresión física',
    'Agresión sexual',
    'Agresión verbal',
    'Agresión psicológica',
    'Agresión digital',
  ];
  List<File> _images = [];
  final int _maxImages = 5;
  String? _audioPath;
  bool _isRecording = false;
  final picker = ImagePicker();
  final recorder = FlutterSoundRecorder();
  Timer? _recordingTimer;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.closeAudioSession();
    _recordingTimer?.cancel();
  }

  Future initRecorder() async {
    await recorder.openAudioSession();
  }

  Future getImage() async {
    if (_images.length >= _maxImages) return;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future startRecording() async {
    ph.PermissionStatus status = await ph.Permission.microphone.request();

    if (status != ph.PermissionStatus.granted) {
      return;
    }
    Directory tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/audio.aac';

    await recorder.startRecorder(toFile: path);

    setState(() {
      _isRecording = true;
      _audioPath = path;
    });

    _recordingTimer = Timer(Duration(minutes: 1), stopRecording);
  }

  Future stopRecording() async {
    await recorder.stopRecorder();

    setState(() => _isRecording = false);

    _recordingTimer?.cancel();
  }

  Future pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'aac'],
      withData: true,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
    } else {
      print('No audio selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes'),
        backgroundColor: Color(0xff5C4DB1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Datos del usuario',
              style: TextStyle(
                color: Color(0xff5C4DB1),
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff5C4DB1)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5C4DB1))),
                errorText: _nameError,
              ),
              onChanged: (value) => setState(() => _userName = value),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff5C4DB1)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5C4DB1))),
                errorText: _emailError,
              ),
              onChanged: (value) => setState(() => _userEmail = value),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Número de teléfono',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff5C4DB1)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5C4DB1))),
                errorText: _phoneError,
              ),
              onChanged: (value) => setState(() => _userPhone = value),
            ),
            SizedBox(height: 16.0),
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Tipo de agresión',
                labelStyle: TextStyle(color: Color(0xff5C4DB1), fontSize: 18.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5C4DB1))),
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
                  items: _aggressions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
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
            // Selector de fecha y hora

            DateTimeField(
              format: format,
              decoration: InputDecoration(labelText: 'Fecha y hora'),
              onChanged: (value) => setState(() => _selectedDateTime = value),
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            ),
            SizedBox(height: 16.0),

// Selector de ubicación
           ElevatedButton(
  onPressed: () async {
    final result = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => MapScreen(),
      ),
    );
    if (result != null) {
      setState(() => _selectedLocation = result);
    }
  },
  child: Text('Seleccionar ubicación'),
),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff5C4DB1)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Adjuntar pruebas',
                      style:
                          TextStyle(color: Color(0xff5C4DB1), fontSize: 18.0)),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      IconButton(
                        onPressed: getImage,
                        iconSize: 30,
                        icon: Icon(Icons.camera_alt_outlined),
                        color: Color(0xff5C4DB1),
                      ),
                      Text('Adjuntar foto (${_images.length}/$_maxImages)',
                          style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      IconButton(
                        onPressed:
                            _isRecording ? stopRecording : startRecording,
                        iconSize: 30,
                        icon: Icon(_isRecording
                            ? Icons.stop
                            : Icons.mic_none_outlined),
                        color: Color(0xff5C4DB1),
                      ),
                      Text(
                          _isRecording
                              ? 'Detener grabación'
                              : 'Grabar audio (máx. 1 minuto)',
                          style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      IconButton(
                        onPressed: pickAudio,
                        iconSize: 30,
                        icon: Icon(Icons.music_note_outlined),
                        color: Color(0xff5C4DB1),
                      ),
                      Text('Adjuntar audio', style: TextStyle(fontSize: 18.0)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
