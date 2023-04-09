import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

import 'main.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}):super(key:key);
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output='';

  @override
  void initState(){
    super.initState();
    loadCamera();
    // loadmodel();
  }

  loadCamera(){
    cameraController=CameraController(cameras![0],ResolutionPreset.medium);
    cameraController!.initialize().then((value){
      if(!mounted){
        return;
      }
      else{
        setState(() {
          cameraController!.startImageStream((imageStream){
            cameraImage=imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async{
    if(cameraImage!=null){
      var prediction=await Tflite.runModelOnFrame(bytesList: cameraImage!.planes.map((plane){
        return plane.bytes;
      }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);
      prediction!.forEach((element) {
        setState(() {
          output=element['label'];
        });
      });
    }
  }

  // loadmodel()async{
  //   await Tflite.loadModel(model: "asset", labels: "asset");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Live Sign Translation')),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width,
              child: !cameraController!.value.isInitialized?
              Container():
              AspectRatio(aspectRatio: cameraController!.value.aspectRatio,
                child: CameraPreview(cameraController!),),
            ),
          ),
          Text(
            output,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}