import 'package:camera/camera.dart';

// Declare the cameras variable globally
List<CameraDescription> cameras = [];

Future<void> initializeCameras() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.description');
  }
}
