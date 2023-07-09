import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';


class CedulaCaptureScreen extends StatefulWidget {
  @override
  _CedulaCaptureScreenState createState() => _CedulaCaptureScreenState();
}

class _CedulaCaptureScreenState extends State<CedulaCaptureScreen> {
   CameraController? _cameraController;
  bool _isCameraInitialized = false;
  TextRecognizer? _textRecognizer;
  String? _capturedText;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeTextRecognizer();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
    );

    await _cameraController?.initialize();

    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _initializeTextRecognizer() {
    _textRecognizer = GoogleMlKit.vision.textRecognizer();
  }

  void _captureImage() async {
    final image = await _cameraController?.takePicture();

    if (image != null) {
      final inputImage = InputImage.fromFilePath(image.path);
      final visionText = await _textRecognizer?.processImage(inputImage);

      setState(() {
        _capturedText = visionText?.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Form App'),
        ),
        body: _isCameraInitialized
            ? Column(
                children: [
                  AspectRatio(
                    
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: CameraPreview(_cameraController!),
                  ),
                  ElevatedButton(
                    onPressed: _captureImage,
                    child: Text('Capture Image'),
                  ),
                  _capturedText != null
                      ? Text(_capturedText!)
                      : SizedBox(),
                  // Aquí puedes auto llenar el formulario con los datos capturados
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}