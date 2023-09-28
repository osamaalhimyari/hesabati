// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

// import 'dart:io';

import 'dart:async';
import 'dart:io';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hesabi_app/auth/SignUpPage.dart';
import 'package:hesabi_app/auth/UserProfile.dart';

import 'package:hesabi_app/auth/authPage.dart';
import 'package:hesabi_app/contents/Globals.dart';
import 'package:hesabi_app/contents/Syslist.dart';

// import 'package:hesabi_app/models/UserModel.dart';
import 'package:hesabi_app/models/sqldb.dart';
// import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pages/homepage.dart';
// import 'package:jiffy/jiffy.dart';

void main() {
  runApp(InitApp());
}

class DateAndTime {
  DateAndTime();

  late String Date;
  late String Time;
  late String Day;
}

late bool isVerified = false;

// class UserAuthClass {
//   UserAuthClass();

//   late int id;
//   late String? name;
//   late String? email;
//   late String? number;
//   late String? password;
//   late File imagePath;

//   late bool state = false;
// }

class InitApp extends StatefulWidget {
  const InitApp({super.key});

  @override
  State<InitApp> createState() => _InitAppState();
}

late List users = [];

class _InitAppState extends State<InitApp> {
  bool isLoading = true;
  SqlDb sqlDb = SqlDb();
  late int id;
  bool delay = true;
  bool empty = true;

  DateTime date = DateTime.now();
  // UserAuthClass user = UserAuthClass();

  Future fetchData() async {
    var response = await sqlDb.fetchData('user');

    users.clear();
    users.addAll(response);
    didchanges = users.length;
    if (users.length > 0) {
      id = users[0]['id'];
      isVerified = users[0]['locked'] == 0 ? true : false;

      print(users[0]['locked']);
      empty = false;
    }
    if (this.mounted) {
      isLoading = false;

      setState(() {});
    } else {
      users = [
        {
          'name': 'name',
          'email': 'email',
          'number': '123',
          'imagePath': 'defoult.jpg',
        }
      ];
    }
    // setState(() {});
  }

  Future getImageFileFromAssets(String fileName) async {
// String unique, String filename
    defoultFilePath = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    File fullPath = File("${defoultFilePath!.path}/${fileName}".trim());
    // print(fullPath);
    // print(fullPath.exists());
    if (await fullPath.exists()) {
      print("image exists===${fileName}  ===== ");
    } else {
      print("image not exists===${fileName}  ===== ");

      ByteData byteData = await rootBundle.load("images/${fileName}");

      // this creates the file image
      File file = await File('${defoultFilePath!.path}/${fileName}'.trim())
          .create(recursive: true);

      // copies data byte by byte
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      getImageFileFromAssets('male.png');
      getImageFileFromAssets('female.png');
    }

    // return File(defoultFilePath!.path);
  }

  @override
  void initState() {
    // to fetch user data
    getImageFileFromAssets('defoult.jpg');

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (users.length == 0 || users.length < didchanges) {
        fetchData();
      } else {}
    });
    // to create a folder if none
    createFolder('hesabiApp');

    // to get the time and date

    // print(DateTime.now());
    // print(DateTime.now().add(Duration(days: 10))); //to add 10 days
    print('=======================');
    // setState(() {});
    // print("${File(defoultFilePath!.path)}");
    // print(
    //     "${Jiffy.now().yMEd.replaceAll('/', '')}:${Jiffy.now().hour}"); // to get the last time you did change

    // setState(() {});
    // Timer(Duration(seconds: 2), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        isLoading = false;
        // user.isVerified = false;
        delay = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // initState();
    // initState();
    // setState(() {});
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: delay == true
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            )
          : (empty == true) //true
              ? UserProfilePage()
              : (isVerified == false)
                  ? AuthPage()
                  : Homepage(),

      routes: {
        // 'LogIn':(context) => AuthPage(id, number, password),

        // 'SignUp': (context) => SignUpPage(),
        'homePage': (context) => InitApp()
      },
      // theme: ThemeData(),
    );
  }

  // buildShowDialog(BuildContext context) {
  //   return showDialog(

  /**
     * 
     * (empty == true)
                  ? AuthPage()
                  : SignUpPage()
     */
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  // }
  // controlsqlpage() {}
}

// _createFolder() async {
//   final folderName = "hesabiApp";
//   final path = Directory("storage/emulated/0/$folderName");

//   if ((await path.exists())) {
//     // TODO:
//     print("exist");
//   } else {
//     // TODO:
//     print("not exist");
//     path.create();
//     return path.path;
// // assetspath.create();
//   }
// }

Future<String> createFolder(String folderName) async {
  final dir = Directory("storage/emulated/0/$folderName");

  // Directory((Platform.isAndroid
  //             ? await getExternalStorageDirectory() //FOR ANDROID
  //             : await getApplicationSupportDirectory() //FOR IOS
  //         )!
  //         .path +
  //     '/$cow');
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await dir.exists())) {
    print('exists');
    // print('${dir.path}');
    return dir.path;
  } else {
    print('exists');

    dir.create();
    // print('${dir.path}');
    return dir.path;
  }
}

Future<String> createFolderInAppDocDir(String folderName) async {
  //Get this App Document Directory
  final Directory _appDocDir = Directory("storage/emulated/0/$folderName");
  //App Document Directory + folder name

  // Platform.isAndroid
  //           ? await getExternalStorageDirectory() //FOR ANDROID
  //           : await getApplicationSupportDirectory();//FOR IOS

  final Directory _appDocDirFolder =
      Directory('${_appDocDir.path}/$folderName/');

  if (await _appDocDirFolder.exists()) {
    //if folder already exists return path
    print("exist");
    print("${_appDocDirFolder.path}");
    return _appDocDirFolder.path;
  } else {
    //if folder not exists create folder and then return its path
    print("not exist");

    final Directory _appDocDirNewFolder =
        await _appDocDirFolder.create(recursive: true);
    print("${_appDocDirFolder.path}");
    return _appDocDirNewFolder.path;
  }
}
