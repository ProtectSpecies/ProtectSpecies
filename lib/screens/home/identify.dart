import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class Page1Camera extends StatefulWidget {
  @override
  _Page1CameraState createState() => _Page1CameraState();
}

class _Page1CameraState extends State<Page1Camera> {
  File selectedFile;

  Widget getImageWidget() {
    if (selectedFile != null) {
      return Image.file(
        selectedFile,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        child: Text('CameraPage'),
      );
    }
  }

  Future getImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.camera);
    if (image != null) {
      File resizedImage = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.deepOrangeAccent,
              toolbarTitle: 'AnimalPicker',
              statusBarColor: Colors.deepPurpleAccent,
              backgroundColor: Colors.white30));
      this.setState(() {
        selectedFile = resizedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getImageWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Colors.blue,
                child: Text('Camera'),
                onPressed: getImage,
              ),
              MaterialButton(
                  color: Colors.orange, child: Text('Device'), onPressed: null)
            ],
          )
        ],
      ),
    );
  }
}
