import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:google_fonts/google_fonts.dart';
class Speech extends StatefulWidget {
  const Speech({super.key});

  @override
  State<Speech> createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
SpeechToText _speechToText =SpeechToText();
bool _isEnabled=false;
String _lastWords='Tap to start';

@override
  void initState() {
    super.initState();
    _initspeech();
  }

  void _initspeech()async{
_isEnabled=await _speechToText.initialize();
setState(() {
  
});
  }

  void _startListening()async{
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }
   void _onSpeechResult(result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        bottom: PreferredSize(preferredSize: Size.fromHeight(1), child:Container(
          color: Colors.grey,
          height: 1,
        )),
        backgroundColor: Colors.white,
        title: Text('Speech Recognition',style: TextStyle(fontFamily: 'Mantinia'),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
               
            ),
            
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  _speechToText.isListening
                      ? 'Listening...'
                          :
                       _lastWords
,
                       style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 68, 65, 64)
                       )
                ),
              ),
            ),
          ],
        ),
      ),
      
      floatingActionButton: Container(
        alignment: Alignment(0, 0.9),
        child: Container(
          width: 90,
          height: 90,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45)
            ),
            onPressed:
                _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          ),
        ),
      ),
    );
  }
}
