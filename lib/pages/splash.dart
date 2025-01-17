import 'package:blind_assistance/first_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
   
    Future.delayed(Duration(milliseconds: 800), () {
    
      Get.off(() => FirstPage(), transition: Transition.zoom, duration: Duration(seconds: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(225, 225, 225, 1),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/I.png'),
          ),
        ),
      ),
    );
  }
}