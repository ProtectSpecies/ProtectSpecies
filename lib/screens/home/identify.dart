import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:tflite/tflite.dart';
import '/models/tflite.dart';
import 'home.dart';
import 'main_pages_wrapper.dart';
import 'package:share/share.dart';

BuildContext context;

class Page1Camera extends StatefulWidget {
  @override
  _Page1CameraState createState() => _Page1CameraState();
}

class _Page1CameraState extends State<Page1Camera> {
  int index = 0;
  Route newRoute = MaterialPageRoute(builder: (BuildContext context) {
    return Page1Camera();
  });

  bool inProcess = false;
  var _output;
  DocumentReference imageRef =
      FirebaseFirestore.instance.collection('imageData').doc();
  File selectedFile;
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

  // ignore: missing_return
  Widget saveImagesWidget() {
    saveImages(selectedFile, imageRef);
  }

  // ignore: missing_return
  Widget shareImageWidget() {
    Share.shareFiles([selectedFile.path]);
  }

  Widget getImageWidget(BuildContext context) {
    if (selectedFile != null) {
      return Image.file(selectedFile,
          // width: 400,
          // height: 700,
          fit: BoxFit.fitHeight);
    } else {
      setState(() {
        index = index + 1;
        print(index.toString() + 'İLK MREHABAAAAAAAAAA');
        return Container(
          height: double.infinity,
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      if (index > 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MyHome()));
          selectedIndex2 = 1;
        });
        index = 0;

        return Container(
          height: double.infinity,
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        print(index.toString() + 'MERHABAAAAAAAAAAAA');
        getImageCamera();
        return Container(
          color: Colors.black,
        );
      }
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
          aspectRatio: CropAspectRatio(ratioX: 13, ratioY: 17.5),
          compressQuality: 100,
          maxHeight: 1200,
          maxWidth: 1200,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.deepOrangeAccent,
              toolbarTitle: 'AnimalPicker',
              statusBarColor: Colors.deepPurpleAccent,
              backgroundColor: Colors.white30));

      this.setState(() {
        runModel(resizedImage);
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
          aspectRatio: CropAspectRatio(ratioX: 13, ratioY: 17.5),
          compressQuality: 100,
          maxHeight: 1200,
          maxWidth: 1200,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.deepOrangeAccent,
              toolbarTitle: 'AnimalPicker',
              statusBarColor: Colors.deepPurpleAccent,
              backgroundColor: Colors.white30));
      setState(() {
        runModel(resizedImage);
        selectedFile = resizedImage;
        inProcess = false;
      });
    }
  }

  runModel(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.5,
    );
    this.setState(() {
      _output = output;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [
          //       Color(0xFF9CCC65),
          //       Color(0xFF7CB342),
          //       Color(0xFF558B2F),
          //       Color(0xFF33691E)
          //     ],
          //     stops: [0.1, 0.4, 0.7, 0.9],
          //   ),
          // ),
          color: Colors.black,
          height: double.infinity,
          width: double.infinity,
        ),
        selectedIndex2 == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getImageWidget(context),
                  SizedBox(
                    height: 23,
                  ),
                  _output == null
                      ? Text("")
                      : Text("${_output[0]["label"]}",
                          style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 23,
                  ),
                  selectedFile != null
                      ? (Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                iconSize: 60,
                                color: Colors.pink,
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return MyHome();
                                  }));
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                            IconButton(
                                iconSize: 60,
                                color: Colors.pink,
                                onPressed: saveImagesWidget,
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )),
                            IconButton(
                                iconSize: 60,
                                color: Colors.pink,
                                onPressed: shareImageWidget,
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ))
                            //   MaterialButton(
                            //     color: Colors.green[900],
                            //     child: Text('Camera'),
                            //     onPressed: getImageCamera,
                            //   ),
                            //   MaterialButton(
                            //       color: Colors.green[900],
                            //       child: Text('Device'),
                            //       onPressed: getImageDevice),
                            //   MaterialButton(
                            //     color: Colors.green[900],
                            //     child: Text('Upload Image'),
                            //     onPressed: saveImagesWidget,
                            //   ),
                          ],
                        ))
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  SizedBox(
                    height: 1,
                  ),
                  selectedFile != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Cancel',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              'Send Us',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              'Share',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )
                          ],
                        )
                      : Container()
                ],
              )
            : (inProcess)
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
