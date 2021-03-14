import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';


class Page1Camera extends StatefulWidget {
  @override
  _Page1CameraState createState() => _Page1CameraState();
}


class _Page1CameraState extends State<Page1Camera> { //TODO: Link image URL in Cloud Firestore

  DocumentReference imageRef = FirebaseFirestore.instance.collection('imageData').doc();
  File _selectedFile;
  final picker = ImagePicker();

  Future<void> saveImages(_image, DocumentReference ref) async {

    Future<String> uploadFile(File _image) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference refer = storage.ref().child("image" + DateTime.now().toString());
      UploadTask uploadTask = refer.putFile(_image);
      uploadTask.then((res) {
        var url = res.ref.getDownloadURL();
        return url.toString();
      });
    }

    String imageURL = await uploadFile(_image);
    ref.set({"imageURL": imageURL});

  }

  Widget saveImagesWidget() {
    saveImages(_selectedFile, imageRef);
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
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
      setState(() {
        _selectedFile = resizedImage;
      });
    }


  }

  Future getImageDevice() async {
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
      setState(() {
        _selectedFile = resizedImage;
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
                onPressed: getImageCamera,
              ),
              MaterialButton(
                  color: Colors.orange,
                  child: Text('Device'),
                  onPressed: getImageDevice),
              MaterialButton(
                color: Colors.purple,
                child: Text('Upload Image'),
                onPressed: saveImagesWidget,
              ),
            ],
          )
        ],
      ),
    );
  }
}
