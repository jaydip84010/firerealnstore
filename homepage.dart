import 'package:firedemo/database_helper.dart';
import 'package:flutter/material.dart';
import 'usermodel.dart';
import 'database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Usermodel> list = [];

  getlistdata() async {
    List<Usermodel> data = await DatabaseHelper.databaseHelper.getdata();

    setState(() {
      list = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlistdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  Usermodel usermodel = list[index];
                  return ListTile(
                    title: Column(
                      children: [
                        Text(usermodel.id.toString()),
                        Text(usermodel.name)
                      ],
                    ),
                    subtitle: Text(usermodel.mobilenumber.toString()),
                  );
                })));
  }
}
