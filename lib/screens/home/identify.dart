import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:tflite/tflite.dart';
import 'main_pages_wrapper.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

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

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  bool inProcess = false;
  dynamic _output = [
    {'index': 1, 'label': ''}
  ];
  int output2 = 3;
  static String _currUID = FirebaseAuth.instance.currentUser.uid;
  DocumentReference imageRef = FirebaseFirestore.instance
      .collection('accounts')
      .doc(_currUID)
      .collection('images')
      .doc();
  DocumentReference userInfo =
      FirebaseFirestore.instance.collection('accounts').doc(_currUID);
  var increment = FieldValue.increment(1);
  File selectedFile;
  final picker = ImagePicker();
  int screenchanger = 0;

  Future<void> saveImages(_image, DocumentReference reference) async {
    Position position = await _determinePosition();

    uploadFile(File _image) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child(_currUID)
          .child("image" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(_image);

      var url = await (await uploadTask).ref.getDownloadURL();
      await userInfo.update({"photosTaken": increment});
      return url;
    }

    String imageURL = await uploadFile(_image);
    reference.set({
      "imageURL": imageURL,
      "type": _output != null ? _output[0]["label"] : '',
      "latitude": position.latitude,
      "longitude": position.longitude
    });
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
      return Image.file(
        selectedFile,
        width: 400,
        height: 426,
        fit: BoxFit.cover,
      );
    } else {
      setState(() {
        index = index + 1;
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
              toolbarTitle: 'Protect Species',
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

  // Future getImageDevice() async {
  //   this.setState(() {
  //     inProcess = true;
  //   });
  //   final image = await ImagePicker().getImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     File resizedImage = await ImageCropper.cropImage(
  //         sourcePath: image.path,
  //         aspectRatio: CropAspectRatio(ratioX: 13, ratioY: 17.5),
  //         compressQuality: 100,
  //         maxHeight: 1200,
  //         maxWidth: 1200,
  //         compressFormat: ImageCompressFormat.jpg,
  //         androidUiSettings: AndroidUiSettings(
  //             toolbarColor: Colors.deepOrangeAccent,
  //             toolbarTitle: 'AnimalPicker',
  //             statusBarColor: Colors.deepPurpleAccent,
  //             backgroundColor: Colors.white30));
  //     setState(() {
  //       runModel(resizedImage);
  //       selectedFile = resizedImage;
  //       inProcess = false;
  //     });
  //   }
  // }
  Widget coloredText() {
    return RichText(
      text: TextSpan(
        text: 'Thank you for taking steps to protect animals. :)' +
            ' Our artificial intelligence mechanism has detected' +
            ' the animal you photographed as a ',
        style: TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: _output != null ? '${_output[0]["label"]}.' : '',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          TextSpan(
              text: ' Since our mechanism is still in development, there is a possibility of making mistakes,' +
                  ' so if you think the animal in the photo you took is correct, you can pass this information' +
                  ' to us by pressing the yes button.However, if you think that the animal you found is not a'),
          TextSpan(
            text: _output != null ? ' ${_output[0]["label"]}' : '',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          TextSpan(
              text: ' write your predictions in the comment section, and you will greatly contribute to ' +
                  'our goal of improving our mechanism and protecting endangered animals.'),
        ],
      ),
    );
  }

  Future mySecondAlertDialog(
    BuildContext context,
  ) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Information'),
            content: Text('With this feature, you send us the information' +
                ' of the photo you took and share the photo, so that other' +
                ' people can see the animals you have found and your contribution' +
                ' to their rescue.If you want to do this, press yes.'),
            actions: [
              MaterialButton(
                  child: Text('No'),
                  elevation: 5,
                  onPressed: () {
                    Navigator.of(context).pop();
                    selectedIndex2 = 1;
                  }),
              MaterialButton(
                  child: Text('Yes'),
                  elevation: 5,
                  onPressed: () {
                    saveImagesWidget();
                    shareImageWidget();
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return MyHome();
                    }));
                    selectedIndex2 = 1;
                  }),
            ],
          );
        });
  }

  runModel(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 12,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.5,
    );
    this.setState(() {
      if (output.length == 1) {
        if (output[0]['confidence'] > 0) {
          _output = output;
        } else {
          output2 = 5;
        }
      } else {
        output2 = 5;
      }
    });
  }

  Future<String> myAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: coloredText(),
            content: TextField(
              controller: customController,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 10),
                  hintText:
                      'You can write the correct animal name or any feedback.'),
            ),
            actions: [
              MaterialButton(
                  child: Text('No'),
                  elevation: 5,
                  onPressed: () {
                    Navigator.of(context).pop();
                    selectedIndex2 = 1;
                  }),
              MaterialButton(
                  child: Text('Yes'),
                  elevation: 5,
                  onPressed: () {
                    saveImagesWidget();

                    Navigator.of(context).pop(customController.text.toString());
                    Navigator.of(context).pushReplacement(_createRoute());
                    selectedIndex2 = 1;
                  }),
            ],
          );
        });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MyHome(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
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
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getImageWidget(context),
                    _output[0].length == 3
                        ? Stack(alignment: Alignment.center, children: [
                            Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width * 1,
                              color: Color(0xFF103A3E),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.23,
                              width: MediaQuery.of(context).size.width * 0.83,
                              alignment: Alignment.center,
                              margin: new EdgeInsets.only(left: 0.0),
                              decoration: new BoxDecoration(
                                color: new Color(0xFFBDE2C8),
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(8.0),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                      _output.length != null
                                          ? "${_output[0]["label"]}"
                                          : '',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 24)),
                                  SizedBox(
                                    height: 23,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FloatingActionButton(
                                          backgroundColor: Color(0xFF103A3E),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                              return MyHome();
                                            }));
                                            selectedIndex2 = 1;
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 40,
                                          )),
                                      FloatingActionButton(
                                          backgroundColor: Color(0xFF103A3E),
                                          onPressed: () {
                                            myAlertDialog(context)
                                                .then((onValue) {
                                              print(onValue);
                                            });
                                          },
                                          child: Icon(
                                            Icons.send,
                                            color: Colors.white,
                                            size: 36,
                                          )),
                                      FloatingActionButton(
                                          backgroundColor: Color(0xFF103A3E),
                                          onPressed: () {
                                            mySecondAlertDialog(
                                              context,
                                            );
                                          },
                                          child: Icon(
                                            Icons.share,
                                            color: Colors.white,
                                            size: 36,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: output2 == 5
                                        ? [Text('')]
                                        : [
                                            Text(
                                              '    Cancel',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              '    Send Us',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              '  Share on\nyour profile',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            )
                                          ],
                                  )
                                ],
                              ),
                            )
                          ])
                        : Container(),
                    // SizedBox(
                    //   height: 23,
                    // // ),
                    // Text(_output.length != null ? "${_output[0]["label"]}" : '',
                    //     style: TextStyle(color: Colors.white)),
                    // SizedBox(
                    //   height: 23,
                    // ),
                    selectedFile != null
                        ? (Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: output2 == 5
                                ? [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          color: Color(0xFF103A3E),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Thanks for trying :), However this doesn't look like an endangered animal.",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Please take another photo and try again.",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    FloatingActionButton(
                                                        backgroundColor:
                                                            Color(0xFF103A3E),
                                                        child: Icon(
                                                          Icons.home,
                                                          size: 35,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                            return MyHome();
                                                          }));
                                                          selectedIndex2 = 1;
                                                        }),
                                                    FloatingActionButton(
                                                        backgroundColor:
                                                            Color(0xFF103A3E),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                            return Page1Camera();
                                                          }));
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_rounded,
                                                          size: 35,
                                                          color:
                                                              Colors.redAccent,
                                                        )),
                                                    SizedBox(
                                                      width: 22,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                30, 30, 2, 30),
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          margin:
                                              new EdgeInsets.only(left: 0.0),
                                          decoration: new BoxDecoration(
                                            color: new Color(0xFF65AB8C),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                new BorderRadius.circular(8.0),
                                            boxShadow: <BoxShadow>[
                                              new BoxShadow(
                                                // color: Colors.white,
                                                blurRadius: 10.0,
                                                offset: new Offset(0.0, 10.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                    // Container(
                                    //   color: Colors.white,
                                    //   child: Text(
                                    //     'Herhangi bir Hayvan Fotoğrafı Çekilmemiş, Bu sayfa düzenlecek',
                                    //     style: TextStyle(fontSize: 9),
                                    //   ),
                                    // )
                                  ]
                                : [],
                          ))
                        : Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                    SizedBox(
                      height: 1,
                    ),
                    selectedFile != null ? Row() : Container()
                  ],
                ),
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
