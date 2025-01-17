import 'package:blind_assistance/pages/blind_person.dart';
import 'package:blind_assistance/pages/deaf_person.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 208, 208),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
          
              icon: ClipOval(child: Image.asset('assets/images/logoi.png',width: 45, fit: BoxFit.cover, ),), // Your image
              iconSize: 20,
               // Set the size of the icon
              onPressed: () {
                // Your onPressed functionality
              },
            ),
            SizedBox(width: 40,),
            Text(
              'InVision',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Mantinia',
                color: Color.fromRGBO(58, 57, 57, 1),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Semantics(
                label: 'Blind Person',
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Color.fromRGBO(224, 224, 224, 1),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                   Get.to(
                    ()=>const Blindperson(),transition: Transition.circularReveal,
                    duration: Duration(milliseconds: 1000),
                   );
                  },
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.asset('assets/lottie/blindman3.json',))
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Blind person",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Mantinia',
                  color: Color.fromRGBO(24, 23, 23, 1),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Semantics(
                  label: 'Deaf Person',
                  hint: 'hi',
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Color.fromRGBO(224, 224, 224, 1),
                      backgroundColor: Color.fromARGB(255, 253, 253, 253),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                  onPressed: () {
                     Get.to(
                    ()=> const DeafPerson(),transition: Transition.fade,
                    duration: Duration(milliseconds: 1000),
                   );
                  },
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.asset('assets/lottie/deaf.json',)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Deaf person',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Mantinia',
                    color: Color.fromRGBO(19, 19, 19, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
