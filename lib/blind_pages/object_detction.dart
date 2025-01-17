import 'package:flutter/material.dart';

class Objectd extends StatelessWidget {
  const Objectd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text(
            'Object Detection',
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Mantinia',
                fontSize: 30),
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
