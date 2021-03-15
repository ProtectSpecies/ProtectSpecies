import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import '/screens/home/identify.dart';
import 'dart:io';

loadModel() async {
  await Tflite.loadModel(
    model: "assets/model_unquant.tflite",
    labels: "assets/labels.txt",
  );
}

runModel(File image) {
  Tflite.runModelOnImage(
    path: image.path,
    numResults: 5,
    imageMean: 127.5,
    imageStd: 127.5,
    threshold: 0.5,
  );
}
