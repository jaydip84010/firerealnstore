import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeData extends StatefulWidget {
  const RealTimeData({Key? key}) : super(key: key);

  @override
  State<RealTimeData> createState() => _RealTimeDataState();
}

class _RealTimeDataState extends State<RealTimeData> {
  final reference = FirebaseDatabase.instance.ref();

  @override
  createdata() async {
    reference.child("jaydip").set({'name': 'jaydip', 'roll': 10});
    reference.child("vishal").set({'name': 'vishal', 'roll': 11});
    reference.child("pratik").set({'name': 'pratik', 'roll': 12});
    reference.child("ankit").set({'name': 'ankit', 'roll': 13});
  }

  readdata() {
    reference.once().then((DataSnapshot) {
      print('Data:${DataSnapshot.snapshot.value}');
    });
  }

  updatedata() {
    reference.child('jaydip').update({'name': "jaydip"});
  }

  delete() {
    reference.child('jaydip').remove();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                createdata();
              },
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: Center(child: Text("Insert")),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                readdata();
              },
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: Center(child: Text("getdata")),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                updatedata();
              },
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: Center(child: Text("update")),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                delete();
              },
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: Center(child: Text("delete")),
              ),
            ),

          ],
        ),
      ),
    ));
  }
}
