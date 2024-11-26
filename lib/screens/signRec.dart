import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';

class SignRecScreen extends StatefulWidget {
  const SignRecScreen({Key? key}) : super(key: key);

  @override
  _SignRecScreenState createState() => _SignRecScreenState();
}

class _SignRecScreenState extends State<SignRecScreen> {
  final TextEditingController _textController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  File? _image;
  late bool _isModelReady;
  String _recognizedText = '';
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _isModelReady = false;
    loadModel();
    initializeCamera();
  }

  Future<void> loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: 'assets/keras_model(1).tflite',
        labels: 'assets/labels(1).txt',
      );
      print('Model loaded: $res');
      setState(() {
        _isModelReady = true;
      });
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );

    await _cameraController.initialize();
    _cameraController.startImageStream((image) {
      if (_isModelReady) {
        _recognizeImage(image);
      }
    });

    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> _recognizeImage(CameraImage image) async {
    var recognitions = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((plane) => plane.bytes).toList(),
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      rotation: 90,
      numResults: 1,
      threshold: 0.5,
      asynch: true,
    );
    if (recognitions != null && recognitions.isNotEmpty) {
      setState(() {
        _recognizedText = recognitions[0]['label'].toLowerCase();
        _textController.text += _recognizedText;
      });
    }
  }

  void _addSpace() {
    setState(() {
      _textController.text += ' ';
    });
  }

  void _clearText() {
    setState(() {
      _textController.clear();
    });
  }

  void _convertToSpeech() async {
    if (_textController.text.isNotEmpty) {
      await _flutterTts.speak(_textController.text);
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _textController.dispose();
    _cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  Widget customButton(BuildContext context, String text, Color color, Function()? onTap) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 50,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return color;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Recognition'),
        backgroundColor: Color.fromARGB(255, 77, 31, 161),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 77, 31, 161),
              Color.fromARGB(255, 148, 87, 189),
              Color.fromARGB(255, 233, 101, 200),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Placeholder for the sign detection area, taking half the screen height
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.white.withOpacity(0.2),
                  child: Center(
                    child: _isCameraInitialized
                        ? CameraPreview(_cameraController)
                        : Text(
                            'Initializing Camera...',
                            style: TextStyle(fontSize: 18, color: Colors.white70),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                // TextField to display recognized letters
                TextField(
                  controller: _textController,
                  maxLines: null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(),
                    labelText: 'Recognized Text',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 20),
                // Row of buttons for space and clear
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customButton(context, 'Space', Colors.deepPurpleAccent, _addSpace),
                    customButton(context, 'Clear', Colors.deepPurpleAccent, _clearText),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // FloatingActionButton to replace the Speak button
      floatingActionButton: FloatingActionButton(
        onPressed: _convertToSpeech,  // Trigger the speech conversion
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.volume_up),  // Speak icon
      ),
    );
  }
}
