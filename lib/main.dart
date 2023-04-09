import 'package:flutter/material.dart';
import 'package:gsol_main/Blind/VR.dart';
import 'package:gsol_main/Home/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';

import 'Blind/Audio.dart';
import 'Login.dart';


List<CameraDescription>? cameras;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          splash: Image.asset("img/logo.png",
            height: 100,
            width: 10000,
          ),

          nextScreen: LoginPage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.amber,
        )

    );
  }
}
