import 'package:firebase_auth/firebase_auth.dart';
import 'package:firedemo/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'otpscreen.dart';
import 'usermodel.dart';
import 'homepage.dart';

class FStoreDemo extends StatefulWidget {
  const FStoreDemo({Key? key}) : super(key: key);

  @override
  State<FStoreDemo> createState() => _FStoreDemoState();
}

class _FStoreDemoState extends State<FStoreDemo> {
  Usermodel usermodel = Usermodel();
  bool Isvisible = false;
  static final form = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationId;
  int? forceResendingToken;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController password = TextEditingController();


  show() {
    setState(() {
      if (Isvisible == false) {
        Isvisible = true;
      } else {
        Isvisible;
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff4c2c2),
      body: SafeArea(
          child: Center(
        child: SizedBox(
          height: 450,
          width: 300,
          child: SingleChildScrollView(
            child: Form(
              key: form,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(
                      child: Text("Sign Up",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "please fill the value";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    controller: name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter name',
                        labelText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "please fill the value";
                      } else {
                       FocusScope.of(context).nextFocus();
                      }
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    controller: phoneNumber,
                    decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter mobile',
                        labelText: 'Mobile Number',
                        suffixIcon: InkWell(
                          onTap: () async {
                            if (phoneNumber.text.isEmpty) {
                              print('value is empty');
                            } else {
                              print('ok');
                              sendOtp();
                              show();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 20,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green,
                            ),
                            child: const Center(
                              child: Text(
                                "Send",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                  ),
                  Visibility(
                      visible: Isvisible,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "otp is wrong";
                            } else {
                              return null;
                            }
                          },
                          maxLength: 6,
                          controller: otp,
                          decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Enter otp',
                              labelText: 'otp'),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val){
                      if (val!.isEmpty && val.length == 8) {
                          return "please enter password";
                      } else {
                        return null;
                      }
                    },
                    controller: password,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter password',
                        labelText: 'Password'),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green),
                        child: const Center(
                          child: Text(
                            "submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if(form.currentState?.validate != null){
                          Database? db= await DatabaseHelper.databaseHelper.database;
                          final result=db?.rawQuery('SELECT * FROM LOG');
                          if(result!=null && result!=form){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Already exist"),
                            ));
                          }
                        }
                        else{
                            Usermodel usermodel = Usermodel();
                            usermodel
                              ..name = name.text
                              ..mobilenumber = phoneNumber.text
                              ..password = password.text;
                            await DatabaseHelper.databaseHelper.insert(usermodel);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                          }


                      })
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  sendOtp() {
    auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneNumber.text}",
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) {}

  void codeAutoRetrievalTimeout(String verificationId) {
    this.verificationId = verificationId;
  }

  void verificationFailed(FirebaseAuthException error) {
    print(error);
  }

  void codeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    this.forceResendingToken = forceResendingToken;
  }

  signInWithPhone(AuthCredential authCredential) async {
    UserCredential userCredential =
        await auth.signInWithCredential(authCredential);
    final User? currentUser = auth.currentUser;
    if (userCredential.user?.uid == currentUser?.uid) {
      Focus.of(context).nextFocus();
    } else {
      print('not verified user');
    }
  }

  Future<void> getUserData() async {
    final data=await DatabaseHelper.databaseHelper.getdata();
  }
}
