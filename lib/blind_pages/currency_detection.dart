import 'package:flutter/material.dart';

class CurrencyDetection extends StatefulWidget {
  const CurrencyDetection({super.key});

  @override
  _CurrencyDetectionState createState() => _CurrencyDetectionState();
}

class _CurrencyDetectionState extends State<CurrencyDetection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _startAnimationWithDelay();
  }

  void _startAnimationWithDelay() async {
    // Delay before starting the animation
    await Future.delayed(const Duration(seconds: 3));
    _controller.forward(); // Start the animation
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
        title: const Text(
          'Currency Detection',
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'Mantinia',
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 211, 208, 208),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(17, 17, 17, 1)),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      
    );
  }
}