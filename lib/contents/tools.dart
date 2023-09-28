// ignore_for_file: non_constant_identifier_names, duplicate_ignore

// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

// import 'package:hesabi_app/contents/Syslist.dart';
// import 'package:hesabi_app/layout/appBar.dart';
// import 'package:hesabi_app/models/routes.dart';
// import 'package:image_picker/image_picker.dart';
// import 'Syslist.dart';
// import '../pages/homepage.dart';
// import '../models/sqldb.dart';
// import '../layout/drawer.dart';

// class variableshome {
//   static const String imagUrl = '1.jpg';
//   static const double vradius = 0;
//   static const String vtitle = 'Osama';
// }

// ignore: non_constant_identifier_names
Text SysgreatText(String vText, double vfontsize, Color fontcolor,
    FontWeight vfontWeight, int fontnumberOfFamily) {
  List fontfamily = <String>['EduSABeginner', 'Roboto'];
  return Text(
    vText,
    style: TextStyle(
      fontSize: vfontsize,
      color: fontcolor,
      fontWeight: vfontWeight,
      fontFamily: fontfamily[fontnumberOfFamily],
    ),
  );
}

// MenuItem SysMenuItem(BuildContext context, int page) {
//   return MenuItem(
//     text: 'Friends',
//     icon: Icons.people,
//     onClicked:
//   );
// }

void SysSelectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Scaffold(), // Page 2
      ));
      break;
  }
}

class PickAnImage {
  var pickedImage;
  late File? image;
  late String imageType = '';
  ImagePicker picker = ImagePicker();
  //
  pickImagefrom() async {
    pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage == null) return;

    File currentPath =
        File(pickedImage.path); // this just to show it teprary befor saveing
    imageType = basename(pickedImage.path).split(".").last;

    image = currentPath;
  }
}
