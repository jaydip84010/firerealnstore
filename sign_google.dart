import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignGoogle extends StatefulWidget {
  const SignGoogle({Key? key}) : super(key: key);

  @override
  State<SignGoogle> createState() => _SignGoogleState();
}

class _SignGoogleState extends State<SignGoogle> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng showLocation = const LatLng(21.1944, 72.5487);
  final Set<Marker> markers = new Set();

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> opengooglesign() async {
    await googleSignIn.signIn();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          myLocationButtonEnabled: true,
          mapToolbarEnabled: true,
          initialCameraPosition: CameraPosition(
            bearing: 192.8334901395799,
            tilt: 59.440717697143555,
            zoom: 19.151926040649414,
            target: LatLng(18.9894, -73.1175),
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          mapType: MapType.normal,
          markers: getmarkers(),
        ),
      ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId("chopati"),
        position: LatLng(21.1944, 72.5487), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'chopati ',
          snippet: 'Surat',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });
    return markers;
  }
}
