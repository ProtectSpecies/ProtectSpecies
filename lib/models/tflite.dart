import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import '/screens/home/identify.dart';
import 'dart:io';

class TfLiteModel extends StatefulWidget {
  @override
  _TfLiteModelState createState() => _TfLiteModelState();
}

class _TfLiteModelState extends State<TfLiteModel> {
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/modelv3.tflite",
      labels: "assets/labels3.txt",
    );
  }

  runModel(File image) {
    Tflite.runModelOnImage(
      path: image.path,
      numResults: 12,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.5,
    );
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
