import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class BarDetection extends StatelessWidget {
  const BarDetection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Hello world!',
              textStyle: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          repeatForever: true,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        backgroundColor: Color.fromARGB(255, 211, 208, 208),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(17, 17, 17, 1)),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
    );
  }
}
