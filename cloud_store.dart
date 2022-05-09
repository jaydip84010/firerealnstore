import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudStore extends StatefulWidget {
  const CloudStore({Key? key}) : super(key: key);

  @override
  State<CloudStore> createState() => _CloudStoreState();
}

class _CloudStoreState extends State<CloudStore> {
  final storedata = FirebaseFirestore.instance.collection('student');

  createdata() async {
    await storedata.add({'marks': 60, 'name': 'vishal', 'rollno': 2});
    await storedata.add({'marks': 80, 'name': 'ankit', 'rollno': 3});
  }

  getdata() {
    storedata.get().then((snapdata) {
      snapdata.docs.forEach((element) {
        print(element.data());
      });
    });
  }

  updatedata(String id) {
    storedata.doc('CDTm7NMATlOk60z5Pdgs').update({'rollno': 5});
  }

  delete() {
    storedata.doc('17xhVXm0VphSwIppaqpU').delete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
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
                getdata();
              },
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: Center(child: Text("fetchdata")),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                updatedata('1');
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
