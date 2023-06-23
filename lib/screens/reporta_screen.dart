import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

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
    PermissionStatus status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
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
                labelStyle:
                    TextStyle(color: Color(0xff5C4DB1), fontSize: 18.0),
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
                labelStyle:
                    TextStyle(color: Color(0xff5C4DB1), fontSize: 18.0),
                border:
                    OutlineInputBorder(borderSide: BorderSide(color: Color(0xff5C4DB1))),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value:_selectedAggression,
                  onChanged:(String? newValue) {
                    setState(() {
                      _selectedAggression = newValue;
                    });
                  },
                  items:_aggressions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value:value,
                      child:Text(value),
                    );
                  }).toList(),
                ),
              ),
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
                        icon:
                            Icon(_isRecording ? Icons.stop : Icons.mic_none_outlined),
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