import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

loadModel() {
  Tflite.loadModel(
    model: "assets/model_unquant.tflite",
    labels: "assets/labels.txt",
  );
}

chooseImage() {}
