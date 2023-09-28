// ignore_for_file: avoid_print

import 'package:jiffy/jiffy.dart';

import '../layout/appBar.dart';
import '../models/sqldb.dart';
import 'package:flutter/material.dart';

class SqlComands extends StatefulWidget {
  const SqlComands({super.key});

  @override
  State<SqlComands> createState() => _SqlComandsState();
}

class _SqlComandsState extends State<SqlComands> {
  SqlDb sqlDb = SqlDb();
  TextEditingController table = TextEditingController();
  TextEditingController insert = TextEditingController();
  TextEditingController delete = TextEditingController();
  TextEditingController update = TextEditingController();

  int action = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarFb2(
        title: "select",
        actions: [],
      ),
      body: Column(
        children: [
          //select
          ElevatedButton(
              onPressed: () async {
                int response = await sqlDb.insertData('user', {
                  'name': "osama",
                  'email': "osama@gmail.com",
                  'number': "777777777",
                  'imagepath': "0.jpg",
                });
                if (response > 0) {
                  setState(() {});
                }
                print(response);
              },
              child: const Text('insert')),
          ElevatedButton(
              onPressed: () async {
                int response = await sqlDb.customUpdate('''
              UPDATE "people" SET "imagePath" ="defoult.jpg" WHERE id =1
              ''');
                print(response);
                if (response > 0) {
                  setState(() {});
                }
              },
              child: const Text('update')),
          ElevatedButton(
              onPressed: () async {
                var response = await sqlDb.deletData('user', 'id=1');
                setState(() {});
                // if (response > 0) {

                // }
                print(response);
              },
              child: const Text('delete')),
          ElevatedButton(
              onPressed: () async {
                List<dynamic> response = await sqlDb.fetchData("people");
                setState(() {});
                print(response);
              },
              child: const Text('read'))
        ],
      ),
    );
  }
}
