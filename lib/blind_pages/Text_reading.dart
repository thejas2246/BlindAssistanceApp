import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';

class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool _isScanning = false;
  String recognizedText = "Press the button to scan";
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initTts();
    flutterTts.speak('Click Scan Text button at the bottom to start');

  }

  void _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4);
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  Future<void> _scanText() async {
    if (_isScanning) return;
    setState(() => _isScanning = true);

    try {
      final image = await _cameraController.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final textRecognizer = TextRecognizer();
      final RecognizedText recognized = await textRecognizer.processImage(inputImage);

      setState(() {
        recognizedText = recognized.text.isNotEmpty ? recognized.text : "No text found";
      });

  
      if (recognized.text.isNotEmpty) {
        await flutterTts.speak(recognizedText);
      }

      textRecognizer.close();
    } catch (e) {
      setState(() {
        recognizedText = "Error: $e";
      });
      await flutterTts.speak("Error occurred during text recognition");
    } finally {
      setState(() => _isScanning = false);
    }
  }
  void stoptext(){
    flutterTts.stop();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 211, 208, 208),
      appBar: AppBar(title: Center(child: const Text("Text Recognition",style: TextStyle(fontFamily: "mantinia",fontSize: 30),)),
        backgroundColor: Color.fromARGB(255, 211, 208, 208),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                width: 100,
                height: 1,
                child: Text(recognizedText, style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                backgroundColor:  Color.fromARGB(255, 73, 164, 248),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              ),
              onPressed: _scanText,
              child: Text('Scan Text',style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'mantinia'
              ),),
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                backgroundColor:  Color.fromARGB(255, 73, 164, 248),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                
              ),
              
              onPressed: stoptext, child: Text('Stop',style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'mantinia',
                fontSize: 19
              ))),
          )
        ],
      ),
    );
  }
}