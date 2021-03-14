import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class Page1Camera extends StatefulWidget {
  @override
  _Page1CameraState createState() => _Page1CameraState();
}

class _Page1CameraState extends State<Page1Camera> {
  bool inProcess = false;
  File selectedFile;
  final picker = ImagePicker();

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

  Future getImageCamera() async {
    this.setState(() {
      inProcess = true;
    });
    final image = await picker.getImage(source: ImageSource.camera);
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
        inProcess = false;
      });
    } else {
      this.setState(() {
        inProcess = false;
      });
    }
  }

  Future getImageDevice() async {
    this.setState(() {
      inProcess = true;
    });
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
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
        inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getImageWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.blue,
                  child: Text('Camera'),
                  onPressed: getImageCamera,
                ),
                MaterialButton(
                    color: Colors.orange,
                    child: Text('Device'),
                    onPressed: getImageDevice)
              ],
            )
          ],
        ),
        (inProcess)
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.94,
                child: Center(child: CircularProgressIndicator()),
              )
            : Center()
      ]),
    );
  }
}
