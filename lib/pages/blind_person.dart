import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blind_assistance/blind_pages/Text_reading.dart';
import 'package:blind_assistance/blind_pages/currency_detection.dart';
import 'package:blind_assistance/blind_pages/face_detection.dart';
import 'package:blind_assistance/blind_pages/object_detction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Blindperson extends StatefulWidget {
  const Blindperson({super.key});

  @override
  _BlindpersonState createState() => _BlindpersonState();
}

class _BlindpersonState extends State<Blindperson>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _startAnimationLoop();
  }

  void _startAnimationLoop() async {
    await Future.delayed(Duration(milliseconds: 800));
    while (true) {
      _controller.forward();
      await Future.delayed(Duration(seconds: 3));
      if (mounted) {
        _controller.reverse();
      }
      await Future.delayed(Duration(seconds: 3));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var colorizeColors = [
    Colors.purple,
    Colors.blue,
    const Color.fromARGB(255, 59, 232, 255),
    const Color.fromARGB(255, 203, 244, 54),
  ];

  var colorizeTextStyle = TextStyle(
    fontSize: 20.0,
    fontFamily: 'Mantinia',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'Blind person page',
          style: TextStyle(
              color: Color.fromRGBO(2, 2, 2, 1),
              fontFamily: 'Mantinia',
              fontSize: 30),
        ),
        backgroundColor: Color.fromARGB(255, 211, 208, 208),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(15, 15, 15, 1)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  //col1
                  SizedBox(
                    width: 350,
                    height: 135,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(223, 221, 221, 1),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        onPressed: () {
                          Get.to(
                            () =>  MyHomePage(),
                            transition: Transition.circularReveal,
                            duration: Duration(seconds: 1),
                          );
                        },
                        child: Row(
                          children: [
                            Lottie.asset(
                              'assets/lottie/eye.json',
                              width: 50,
                              height: 50,
                              controller: _controller,
                              onLoaded: (composition) {
                                _controller.duration = composition.duration;
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Object Detection',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Mantinia',
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'describes surroundings using ',
                                  style: TextStyle(
                                    fontFamily: 'Mantinia',
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'feedback audio ',
                                  style: TextStyle(
                                      fontFamily: 'Mantinia',
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  //col2
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    height: 135,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(223, 221, 221, 1),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        onPressed: () {
                          Get.to(
                            () => const TextDetecton(),
                            transition: Transition.circularReveal,
                            duration: Duration(seconds: 1),
                          );
                        },
                        child: Row(
                          children: [
                            Lottie.asset(
                              'assets/lottie/camera1.json',
                              width: 50,
                              height: 50,
                              controller: _controller,
                              onLoaded: (composition) {
                                _controller.duration = composition.duration;
                              },
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: 160,
                                    height: 50,
                                    child: Text(
                                      'Text Recognition',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Mantinia',
                                          color: Colors.black),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Reads text aloud for easy ',
                                  style: TextStyle(
                                      fontFamily: 'Mantinia',
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'comprehension.  ',
                                  style: TextStyle(
                                      fontFamily: 'Mantinia',
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  //col3
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    height: 135,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(223, 221, 221, 1),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        onPressed: () {
                          Get.to(
                            () =>  CurrencyDetection(title:'currency'),
                            transition: Transition.circularReveal,
                            duration: Duration(seconds: 1),
                          );
                        },
                        child: Row(
                          children: [
                            Lottie.asset(
                              'assets/lottie/pig1.json',
                              width: 50,
                              height: 50,
                              controller: _controller,
                              onLoaded: (composition) {
                                _controller.duration = composition.duration;
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 200.0,
                                  child: SizedBox(
                                      width: 250.0,
                                      child: Text(
                                        "Currency Detection",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Mantinia',
                                            color: Colors.black),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Identifies indian currency  ',
                                  style: TextStyle(
                                      fontFamily: 'Mantinia',
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'and announces its value  ',
                                  style: TextStyle(
                                      fontFamily: 'Mantinia',
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  //col4
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    height: 135,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(223, 221, 221, 1),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        onPressed: () {
                          Get.to(
                            () => const BarDetection(),
                            transition: Transition.circularReveal,
                            duration: Duration(seconds: 1),
                          );
                        },
                        child: Row(
                          children: [
                            Lottie.asset(
                              'assets/lottie/man.json',
                              width: 50,
                              height: 50,
                              controller: _controller,
                              onLoaded: (composition) {
                                _controller.duration = composition.duration;
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Face Recognition",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Mantinia',
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Detects and recognizes faces  ',
                                  style: TextStyle(
                                      fontFamily: 'Mantinia',
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'using the camera.',
                                  style: TextStyle(
                                      fontFamily: 'Mantinia',
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
