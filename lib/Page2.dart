import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ImageProcessingPage extends StatefulWidget {
  @override
  _ImageProcessingPageState createState() => _ImageProcessingPageState();
}

class _ImageProcessingPageState extends State<ImageProcessingPage> {
  File? _image;
  bool _isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    // Load the TFLite model
    loadModel();
  }

  // Load the TFLite model
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite', // replace with your TFLite model file path
      labels: 'assets/labels.txt', // replace with your TFLite labels file path
    );
  }

  // Function to pick an image from gallery
  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _isImageLoaded = true;
      });
    }
  }

  // Function to process the image using TFLite model
  Future<void> _processImage() async {
    if (_image != null) { // Check if _image is not null
      // Run inference on the image using TFLite
      List<dynamic>? result = await Tflite.runModelOnImage(
        path: _image!.path,
        numResults: 2,
      );

      if (result != null) { // Check if result is not null
        // Process the result
        // ...
      }
    }
  }




  // Process the inference results
      String processedResult = 'Results:\n';
      for (dynamic res in result) {
        processedResult += '${res['label']}: ${res['confidence']}\n';
      }

      // Show the processed result in a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Image Processing Result'),
            content: Text(processedResult),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    // Unload the TFLite model when the widget is disposed
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Processing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isImageLoaded
                ? Image.file(_image, width: 300, height: 300)
                : Text('No Image Selected'),
            RaisedButton(
              child: Text('Pick Image'),
              onPressed: pickImageFromGallery,
            ),
            RaisedButton(
              child: Text('Process Image'),
              onPressed: processImage,
            ),
          ],
        ),
      ),
    );
  }
}
