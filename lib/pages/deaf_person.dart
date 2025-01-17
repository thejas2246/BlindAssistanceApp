import 'package:blind_assistance/deaf_pages/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DeafPerson extends StatefulWidget {
  const DeafPerson({super.key});

  @override
  State<DeafPerson> createState() => _DeafPersonState();
}

class _DeafPersonState extends State<DeafPerson> with SingleTickerProviderStateMixin{

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text(
            'Blind person page',
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Mantinia',
                fontSize: 30),
          ),
          backgroundColor: Color.fromARGB(255, 211, 208, 208),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(17, 17, 17, 1)),
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
        ),
        body: Center(
          child: Column(
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
                      elevation: 5,
                        backgroundColor: Color.fromRGBO(223, 221, 221, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    onPressed: () {
                        Get.to(
                    ()=> const Speech(),transition: Transition.fade,
                    duration: Duration(seconds: 1),
                 );
                    },
                    child: Row(
                      children: [
                        Lottie.asset(
                          'assets/lottie/headphone.json',
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
                              'Speech to text',
                              style: TextStyle(
                                  fontFamily: 'Mantinia',
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Converts speech into text for ',
                              style: TextStyle(
                                  fontFamily: 'Mantinia',
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'easy reading. ',
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
        ));
  }
}
