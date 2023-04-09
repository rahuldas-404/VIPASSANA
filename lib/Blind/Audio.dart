import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:gsol_main/Blind/Name.dart';

import '../Home/home.dart';

class AskQuestionPage extends StatefulWidget {
  @override
  _AskQuestionPageState createState() => _AskQuestionPageState();
}

class _AskQuestionPageState extends State<AskQuestionPage> {
  FlutterTts _flutterTts = FlutterTts();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  bool _isBlind = false;

  @override
  void initState() {
    super.initState();
    _askQuestion();
  }

  void _askQuestion() async {
    await _speak('Are you blind?');
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
            if (answer.contains('yes')) {
              _isBlind = true;
            } else {
              _isBlind = false;
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _isBlind ? Name() : Home()),
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