import 'package:firedemo/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Form2 extends StatefulWidget {
  const Form2({Key? key}) : super(key: key);

  @override
  State<Form2> createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  final storedata = FirebaseFirestore.instance.collection('user');
  TextEditingController name = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  final form = GlobalKey<FormState>();
  var uname;
  var uphone;

  @override
  void initState() {
    super.initState();
    getdata();
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
            ],
          ),
        ),
      )),
    );
  }

  void insertdata() async {
    await storedata.add({'name': name.text, 'phoneno': phoneno.text});
  }

  getdata() async {
    List<Usermodel2> list = [];
    final storedata = FirebaseFirestore.instance.collection('user');
    storedata.get().then((value) {
      value.docs.forEach((element) {
        print(element.data());

      });
    });
  }

  void updatedata() async {
    await storedata.doc().update({'name': name.text, 'phoneno': phoneno.text});
  }

  void deletedata() {
    storedata.doc('').delete();
  }
}
