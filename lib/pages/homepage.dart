import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hesabi_app/main.dart';
import '../contents/Syslist.dart';
// import 'package:hesabi_app/data.dart';
// // import 'package:hesabi_app/DetailsPage.dart';
// import 'package:hesabi_app/list.dart';
import '../contents/dialog.dart';
import '../layout/appBar.dart';
import '../layout/drawer.dart';
import '../layout/header.dart';
// import 'package:persistent_header_adaptive/adaptive_height_sliver_persistent_header.dart';
import 'package:persistent_header_adaptive/persistent_header_adaptive.dart';

import '../models/sqldb.dart';

/// header
///

// class slideHeader extends StatelessWidget {
//   const slideHeader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

const primaryColor = Color.fromARGB(255, 43, 45, 118);

class _HomepageState extends State<Homepage> {
  var i = 0;
  var j = 0;
  // SqlDb sqlDb = SqlDb();
  // bool isLoading2 = true;
  // List person = [];

  // Future fetchData() async {
  //   List<Map> response = await sqlDb.fetchData('people');
  //   person.clear();
  //   person.addAll(response);
  //   differentLength = person.length;
  //   isLoading2 = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   setState(() {});
  // }

  // // late SwipeActionController controller;
  // @override
  // void initState() {
  //   fetchData();
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (person.length < differentLength || person.isEmpty) {
  //       fetchData();
  //     }
  //   });

  //   // setState(() {});
  //   // Future.delayed(Duration(seconds: 2), () {
  //   //   setState(() {
  //   //   // user.isVerified = false;
  //   //   });
  //   // });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // isVerified = true;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarFb2(
          title: "حساباتي",
          actions: [
            Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    // iconSize: 50,
                    onTap: () {
                      dialogForm(context);
                      print('hello');
                    },
                  ),
                );
              },
            )
          ],
        ),

        drawer: DrawerFb2(0, 1, users.first['name'], users.first['email'],
            users.first['number'], File(users.first['imagePath'])),

        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              AdaptiveHeightSliverPersistentHeader(
                floating: true,
                child: Header(),
              ),
              SysList(
                static: false,
              ),
            ],
          ),
        ),
        // FutureBuilder<List>(
        //   future: Future.value(model.users),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return SafeArea(child: Homepage());
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
      ),
    );
  }
}

////