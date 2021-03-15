import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';


class Page1Camera extends StatefulWidget {
  @override
  _Page1CameraState createState() => _Page1CameraState();
}


class _Page1CameraState extends State<Page1Camera> { //TODO: Link image URL in Cloud Firestore
  bool inProcess = false;
  DocumentReference imageRef = FirebaseFirestore.instance.collection('imageData').doc();
  File _selectedFile;
  final picker = ImagePicker();

  Future<void> saveImages(_image, DocumentReference reference) async {

    uploadFile(File _image) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("image" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(_image);

      var url = await (await uploadTask).ref.getDownloadURL();
      return url;

    }

    String imageURL = await uploadFile(_image);
    reference.set({"imageURL": imageURL});

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
        padding: EdgeInsets.all(40),
        child: Text(
              "Camera Page",
              style: TextStyle(
              color: Colors.green[900],
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
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
        _selectedFile = resizedImage;
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
      setState(() {
        _selectedFile = resizedImage;
        inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF9CCC65), Color(0xFF7CB342), Color(0xFF558B2F), Color(0xFF33691E)],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            height: double.infinity,
            width: double.infinity,
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getImageWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.green[900],
                  child: Text('Camera'),
                  onPressed: getImageCamera,
                ),
                MaterialButton(
                    color: Colors.green[900],
                    child: Text('Device'),
                    onPressed: getImageDevice
                ),
                MaterialButton(
                  color: Colors.green[900],
                  child: Text('Upload Image'),
                  onPressed: saveImagesWidget,
                ),
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
