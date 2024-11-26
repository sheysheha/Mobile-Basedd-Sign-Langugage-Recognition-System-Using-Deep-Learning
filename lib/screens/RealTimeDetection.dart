import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure cameras are initialized
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  MyApp({required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: GestureRecognition(camera: camera),
    );
  }
}

class GestureRecognition extends StatefulWidget {
  final CameraDescription camera;

  GestureRecognition({required this.camera});

  @override
  _GestureRecognitionState createState() => _GestureRecognitionState();
}

class _GestureRecognitionState extends State<GestureRecognition> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String prediction = "";
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      setState(() {
        isCameraInitialized = true;
      });
    });

    loadModel();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  predictImage(CameraImage img) async {
    var recognitions = await Tflite.runModelOnFrame(
      bytesList: img.planes.map((plane) => plane.bytes).toList(),
      imageHeight: img.height,
      imageWidth: img.width,
      imageMean: 127.5,
      imageStd: 127.5,
      rotation: 90,
      numResults: 1,
      threshold: 0.5,
      asynch: true,
    );

    setState(() {
      prediction = recognitions?.isNotEmpty == true
          ? recognitions![0]["label"]
          : "No gesture detected";
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    Tflite.close();
    super.dispose();
  }

  void startCameraStream() {
    _controller.startImageStream((image) {
      predictImage(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hand Gesture Recognition')),
      body: Column(
        children: [
          if (isCameraInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller),
            ),
          SizedBox(height: 20),
          Text(
            'Prediction: $prediction',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: startCameraStream,
            child: Text('Start Camera'),
          ),
        ],
      ),
    );
  }
}
