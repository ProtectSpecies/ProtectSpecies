import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'main_pages_wrapper.dart';

class OrgAccount extends StatefulWidget {
  const OrgAccount({Key key}) : super(key: key);

  @override
  _OrgAccountState createState() => _OrgAccountState();
}

bool mapToggle = false;
GoogleMapController mapController;
const LatLng center = const LatLng(36.521563, 36.277433);

void initState() {
  populateUsers();
  setState() {
    mapToggle = true;
  }
}

populateUsers() {
  List users = [];
  FirebaseFirestore.instance.collection('accounts').doc();
}

class _OrgAccountState extends State<OrgAccount> {
  List<Marker> markers = [];
  bool done;

  Future<void> getMapLocations() async {
    var allImages = FirebaseFirestore.instance.collectionGroup('images');
    QuerySnapshot querySnapshot = await allImages.get();
    Marker resultMarker;
    for (var doc in querySnapshot.docs) {
      try {
        double lat = doc.data()['latitude'];
        double lng = doc.data()['longitude'];

        if (lat != null && lng != null) {
          resultMarker = Marker(
            markerId: MarkerId(doc['type']),
            infoWindow: InfoWindow(
              title: doc.data()['type'],
            ),
            position: LatLng(lat, lng),
          );
          markers.add(resultMarker);
        }
      } catch (e) {
        print(e);
      }
      done = true;
    }

    return () => done;
  }

  @override
  void initState() {
    super.initState();
    done = false;
  }

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
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    child: FutureBuilder(
                        future: getMapLocations(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GoogleMap(
                              onMapCreated: onMapCreated,
                              initialCameraPosition:
                                  CameraPosition(target: center, zoom: 10),
                              markers: Set.from(markers),
                            );
                          }
                        }))
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
