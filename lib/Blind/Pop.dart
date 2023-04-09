import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gsol_main/Blind/VR.dart';
 // Replace with the actual name of your next screen class

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    playTextToSpeech(); // Play TTS and navigate to next screen after 5 seconds
  }

  // Function to play text-to-speech
  Future<void> playTextToSpeech() async {
    await flutterTts.speak("Now the next screen will be open which is VR mode for live translation so, it is requested to gear up with your VR set");
    // Wait for 5 seconds, then navigate to next screen
    Timer(Duration(seconds: 9), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VR(), // Replace with the actual name of your next screen class
        ),
      );
    });
  }

  @override
  void dispose() {
    flutterTts.stop(); // Stop TTS when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
