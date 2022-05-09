import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'usermodel.dart';

class Form1 extends StatefulWidget {
  const Form1({Key? key}) : super(key: key);

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  Usermodel1 usermodel = Usermodel1();
  final reference = FirebaseDatabase.instance.ref();
  final form = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  var uname;
  var uphone;
  var user = User;
  List<Usermodel1> list = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  insertdata() async {
    reference
        .child("users/${name.text}")
        .set({'name': name.text, 'phoneno': phoneno.text});
  }

  getdata() {
    List<Usermodel1> item = [];
    final ref = FirebaseDatabase.instance.ref().child('users');
    // ref.once().then((value) {
    //   print(value.snapshot.value);
    //   value.snapshot.children.forEach((element) {
    //     print(element.value);
    //     Map<String,dynamic> map = element.value as Map<String,dynamic>;
    //     list.add(Usermodel1.fromjson(map));
    //   });
    // });
    ref.onValue.listen((event) {
      print((event.snapshot));
      event.snapshot.children.forEach((element) {
        print(element.value);
        Map<String, dynamic> map =
            Map<String, dynamic>.from(element.value as Map);
        setState(() {
          list.add(Usermodel1.fromjson(map));
        });
      });
    });
    // ref.onChildAdded.asyncMap((event) {
    //   print(event.snapshot.value);
    // }
    // );
  }

  updatedata() async {
    reference
        .child(name.text)
        .update({'name': name.text, 'phoneno': phoneno.text});
  }

  deletedata() async {
    reference.child(name.text).remove();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                validator: (val) {
                  if (val != null) {
                    return null;
                  } else {
                    return "value is empty";
                  }
                },
                keyboardType: TextInputType.text,
                controller: name,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your name',
                  labelText: 'Name',
                ),
                onChanged: (value) {
                  name = value as TextEditingController;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (val) {
                  if (val != null) {
                    return null;
                  } else {
                    return "value is empty";
                  }
                },
                keyboardType: TextInputType.number,
                controller: phoneno,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.phone),
                  hintText: 'Enter a phone number',
                  labelText: 'Phone',
                ),
                onChanged: (value) {
                  uphone = value as TextEditingController;
                },
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (name.text.isNotEmpty) {
                    insertdata();
                  }
                },
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: Center(child: Text("Add")),
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
                  child: Center(child: Text("getdata")),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (form.currentState?.validate() == true) {
                    updatedata();
                  }
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
                  deletedata();
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
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: list.length>0?ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    Usermodel1 model = list[index];
                    return Row(
                      children: [
                        Text(model.name??""),
                        SizedBox(width: 10,),
                        Text("-"),
                        SizedBox(width: 10,),
                        Text(model.phoneno??""),
                      ],
                    );
                  },
                ):Container(),
              )
            ],
          ),
        ),
      )),
    );
  }
}
