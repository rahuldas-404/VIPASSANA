import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gsol_main/Blind/Age.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:gsol_main/Blind/Name.dart';

class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  FlutterTts _flutterTts = FlutterTts();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  bool _isBlind = false;
  String _speechText = '';

  @override
  void initState() {
    super.initState();
    _askQuestion();
  }

  void _askQuestion() async {
    await _speak('What is your name?');
    await Future.delayed(Duration(seconds: 1));
    _listenForAnswer();
  }

  void _listenForAnswer() async {
    setState(() {
      _isListening = true;
    });

    if (await _speechToText.initialize()) {
      _speechToText.listen(
        onResult: (result) {
          setState(() {
            _isListening = false;
          });

          if (result.finalResult) {
            String answer = result.recognizedWords.toLowerCase();
            print('User answered: $answer');
            _speechText = answer; // Store the speech to text input
            if (answer.isNotEmpty) {
              _isBlind = true;
            } else {
              _isBlind = false;
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _isBlind ? Age() : Name()),
            );
          }
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to initialize speech recognition.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isListening
            ? CircularProgressIndicator()
            : Text('Asking question...'),
      ),
    );
  }
}
