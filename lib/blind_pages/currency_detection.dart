import 'dart:math';
import 'dart:ui';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
late List<CameraDescription> cameras;
late FlutterTts flutterTts;

class CurrencyDetection extends StatefulWidget {
  CurrencyDetection({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CurrencyDetection> {
  
  dynamic controller;
  bool isBusy = false;
  dynamic objectDetector;
  late Size size;

  bool isSpeaking = false;
  Set<String> spokenLabels = {};
void start() async{
WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
}
 @override
void initState(){
  super.initState();
  start();
  flutterTts = FlutterTts();
  flutterTts.setSpeechRate(0.5);
  flutterTts.setPitch(1.0);
  flutterTts.setVolume(1.0);
  

  flutterTts.setCompletionHandler(() {
    setState(() {
      isSpeaking = false;
    });
  });

  initializeCamera();
}
  initializeCamera() async {
    final mode = DetectionMode.stream;
    final modelPath = await _getModel('assets/ml/currencyfull95.tflite');
    final options = LocalObjectDetectorOptions(
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
      mode: mode,
    );
    objectDetector = ObjectDetector(options: options);

    controller = CameraController(
      cameras[0],
      ResolutionPreset.max,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    await controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller.startImageStream((image) => {
        if (!isBusy)
          {
            isBusy = true,
            img = image,
            doObjectDetectionOnFrame()
          }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    objectDetector.close();
    super.dispose();
  }

  Future<String> _getModel(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(
          byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  dynamic _scanResults;
  CameraImage? img;

  doObjectDetectionOnFrame() async {
  var frameImg = getInputImage();
  List<DetectedObject> objects = await objectDetector.processImage(frameImg);
  
 
  objects = objects.where((obj) => obj.labels.any((label) => label.confidence >= 0.7
  )).toList();

  print("Filtered Objects Count: ${objects.length}");

  setState(() {
    _scanResults = objects;
  });

  
  processLabels(objects);
  isBusy = false;
}


  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? getInputImage() {
    final camera = cameras[0];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;

    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }

    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(img!.format.raw);
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    if (img!.planes.length != 1) return null;
    final plane = img!.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(img!.width.toDouble(), img!.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

processLabels(List<DetectedObject> objects) async {
  for (var detectedObject in objects) {
    for (var label in detectedObject.labels) {
      if (label.confidence >= 0.7 && label.text.isNotEmpty && 
          !spokenLabels.contains(label.text) && !isSpeaking && 
          label.text != "0 hundred rupees") {
        
        spokenLabels.add(label.text);
        isSpeaking = true;

        
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(label.text);
        
        setState(() {
          isSpeaking = false;
        });

        await Future.delayed(Duration(seconds: 1));

       
        Future.delayed(Duration(seconds: 2), () {
          spokenLabels.remove(label.text);
        });
      }
    }
  }
}

  Widget buildResult() {
    if (_scanResults == null ||
        controller == null ||
        !controller.value.isInitialized) {
      return Text('');
    }

    final Size imageSize = Size(
      controller.value.previewSize!.height,
      controller.value.previewSize!.width,
    );
    CustomPainter painter = ObjectDetectorPainter(imageSize, _scanResults);
    return CustomPaint(
      painter: painter,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    size = MediaQuery.of(context).size;
    if (controller != null) {
      stackChildren.add(
        Positioned(
          top: 0.0,
          left: 0.0,
          width: size.width,
          height: size.height,
          child: Container(
            child: (controller.value.isInitialized)
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  )
                : Container(),
          ),
        ),
      );

      stackChildren.add(
        Positioned(
            top: 0.0,
            left: 0.0,
            width: size.width,
            height: size.height,
            child: buildResult()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Currency detector",style: TextStyle(fontFamily: "mantinia",fontSize: 30),)),
         backgroundColor: Color.fromARGB(255, 211, 208, 208),
      ),
      backgroundColor: Colors.black,
      body: Container(
          margin: const EdgeInsets.only(top: 0),
          color: Colors.black,
          child: Stack(
            children: stackChildren,
          )),
    );
  }
}

class ObjectDetectorPainter extends CustomPainter {
  ObjectDetectorPainter(this.absoluteImageSize, this.objects);

  final Size absoluteImageSize;
  final List<DetectedObject> objects;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.pinkAccent;

    for (DetectedObject detectedObject in objects) {
      for (Label label in detectedObject.labels) {
        if (label.confidence < 0.7) continue; 

        print("Label: ${label.text}, Confidence: ${label.confidence.toStringAsFixed(2)}");

        canvas.drawRect(
          Rect.fromLTRB(
            detectedObject.boundingBox.left * scaleX,
            detectedObject.boundingBox.top * scaleY,
            detectedObject.boundingBox.right * scaleX,
            detectedObject.boundingBox.bottom * scaleY,
          ),
          paint,
        );

        if (label.text != "0 hundred rupees") {
          TextSpan span = TextSpan(
            text: label.text,
            style: const TextStyle(fontSize: 25, color: Colors.blue),
          );
          TextPainter tp = TextPainter(
            text: span,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
          );
          tp.layout();
          tp.paint(
            canvas,
            Offset(detectedObject.boundingBox.left * scaleX,
                detectedObject.boundingBox.top * scaleY),
          );
        }

        break;
      }
    }
  }

  @override
  bool shouldRepaint(ObjectDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.objects != objects;
  }
}
