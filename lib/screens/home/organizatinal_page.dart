import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OrgAccount extends StatefulWidget {
  const OrgAccount({Key key}) : super(key: key);

  @override
  _OrgAccountState createState() => _OrgAccountState();
}

GoogleMapController mapController;
const LatLng center = const LatLng(38.521563, 33.677433);

void initState() {
  populateUsers();
}

populateUsers() {
  List users = [];
  FirebaseFirestore.instance.collection('accounts').doc();
}

class _OrgAccountState extends State<OrgAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF103A3E),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  child: GoogleMap(
                    onMapCreated: onMapCreated,
                    initialCameraPosition:
                    CameraPosition(target: center, zoom: 10),
                  ),
                )
              ],
            )
          ],
        ));
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
