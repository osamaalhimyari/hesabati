// ignore_for_file: prefer_const_constructors, file_names, camel_case_types, duplicate_ignore

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hesabi_app/contents/Globals.dart';
import 'package:hesabi_app/contents/Syslist.dart';
// import 'package:flutter/rendering.dart';
import 'package:hesabi_app/contents/image_container.dart';
import 'package:hesabi_app/main.dart';
import 'package:hesabi_app/models/sqldb.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart';
//
// import 'package:hesabi_app/DataClass.dart';
// import 'package:hesabi_app/flutter/homepage.dart';
import '../layout/appBar.dart';
import '../contents/tools.dart';
import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class detailspage extends StatefulWidget {
  const detailspage(this.index, this.id, this.name, this.email, this.number,
      this.imageUrl, this.table, this.title,
      {super.key});
  final File imageUrl;
  final String name;
  final String email;
  final String number;
  final String title;
  final String table;
  final int index;
  final int id;
  // final String email; this.email, this.number,
  // final String number;

  @override
  State<detailspage> createState() => _detailspageState();
}

late String imageNewName;
late XFile pickedImage;
late bool allowChang = false;
PickAnImage pickAnImage = PickAnImage();

class _detailspageState extends State<detailspage> {
  SqlDb sqlDb = SqlDb();

  late String? nameData = widget.name;
  late String? describtionData = widget.title;
  late String? emailData = widget.email;
  late String? numberData = widget.number;
  List<bool> allowChange = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  final GlobalKey<FormState> fromDetailsState = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController describtion = TextEditingController();

  void UpdateData() async {
    late String dateModify = "${Jiffy.now().yMEd}:${Jiffy.now().hour}";
    bool listbool = false;
    if ((allowChange[0] && widget.table == 'people') ||
        (allowChang && widget.table == 'people')) {
      allowChange[0] = false;
      dateModify = "${Jiffy.now().yMEd}:${Jiffy.now().hour}";
      listbool = true;
      int resp = await sqlDb.updatehData(
          widget.table, {'dateModify': dateModify}, 'id=${widget.id}');
      print('$resp    changed===========0===');
      setState(() {
        differentLength++;
      });
    }

    if (allowChange[1]) {
      allowChange[1] = false;
      listbool = true;
      int resp = await sqlDb.updatehData(
          widget.table,
          {
            'name': "${name.text}",
          },
          'id=${widget.id}');

      print('$resp    changed===========1===');
    }

    if (allowChange[2]) {
      allowChange[2] = false;
      listbool = true;
      int resp = await sqlDb.updatehData(
          widget.table,
          {
            'email': "${email.text}",
          },
          'id=${widget.id}');
      print('$resp    changed===========2===');
    }

    if (allowChange[3]) {
      allowChange[3] = false;
      listbool = true;
      int resp = await sqlDb.updatehData(
          widget.table,
          {
            'number': "${number.text}",
          },
          'id=${widget.id}');
      print('$resp    changed===========3===');
    }

    if (allowChange[4] && widget.table == 'people') {
      allowChange[4] = false;
      listbool = true;
      int resp = await sqlDb.updatehData(
          widget.table,
          {
            'title': "${describtion.text}",
          },
          'id=${widget.id}');
      print('$resp    changed===========4===');
    }
    if (allowChang) {
      allowChang = false;
      allowChange[5] = false;
      listbool = true;
      pickAnImage.pickedImage.saveTo("${defoultFilePath!.path}/$imageNewName");

      int resp = await sqlDb.updatehData(
          widget.table,
          {
            'ImagePath': "${imageNewName}",
          },
          'id=${widget.id}');
      print('$resp    changed===========4===');
    }

    if (widget.table == 'people' && listbool == true) {
      setState(() {
        differentLength++;
        didchanges++;
      });
    } else {}

//  person[widget.index]['imagePath'] = imageNewName
    // : users[widget.index]['imagePath'] = imageNewName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: AppBarFb2(
        title: "data",
        actions: [
          _ContextMenuDemo(context),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            CupertinoContextMenuDemo(
                File("${widget.imageUrl.path}"), name.text),
            SizedBox(
              height: 10,
            ),

            FormEditText(
                1, nameData, 'name'), // FormEditText(3, widget.imageUrl.path),
            (widget.table == 'people'
                ? FormEditText(4, describtionData, 'description')
                : SizedBox(height: 0)),
            FormEditText(2, numberData, 'number'),
            FormEditText(3, emailData, 'email'),
            Divider(),

            InkWell(
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('data updated successfully')));

                  UpdateData();
                },
                child: Container(
                    alignment: Alignment.bottomRight,
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(51, 56, 150, 1),
                          Color.fromRGBO(27, 30, 92, 0.6)
                        ])),
                    child: Center(
                        child: Text("save",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))))

            //
          ],
        ),
      ),
    );
  }

// _container(
//   '${widget.email}',
//   Icons.email,
// ),
  Container _container(String text, IconData icon) {
    return Container(
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        color: Color.fromARGB(255, 43, 47, 69),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(
                icon,
                color: Color.fromARGB(255, 255, 252, 252),
              ),
              SizedBox(
                height: 0,
                width: 15,
              ),
              SysgreatText(text, 22, const Color.fromARGB(255, 255, 255, 255),
                  FontWeight.normal, 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget FormEditText(int ControlerCase, initValue, String hint) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initValue,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          // hintText: ,
          label: Text('$hint'),
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          // ControlerValue = value;
          allowChange[0] = true;

          switch (ControlerCase) {
            case 1:
              name.text = value;
              allowChange[ControlerCase] = true;

              // print(name.text);
              break;
            case 2:
              number.text = value;
              // print(number.text);
              allowChange[ControlerCase] = true;
              break;
            case 3:
              email.text = value;
              // print(email.text);
              allowChange[ControlerCase] = true;
              break;
            case 4:
              describtion.text = value;
              allowChange[ControlerCase] = true;
              break;
            case 5:
              break;
            case 6:
              break;
          }
        },
      ),
    );
  }

  Widget _ContextMenuDemo(BuildContext context) {
    List<Map> menues = [
      {'text': 'Edit', 'value': 'true'},
      // {'text': '', 'value': ''},
      // {'text': '', 'value': ''},
    ];
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      itemBuilder: (context) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
            value: menues[0]['value'], child: Text(menues[0]['text'])),
        // PopupMenuItem<String>(
        //     value: menues[2]['value'], child: Text(menues[2]['text'])),
      ],
    );
  }

  // Widget _imageViewer() {
  //   double height = 200;
  //   double width = 200;

  //   // final galleryLocalizations = GalleryLocalizations.of(context)!;
  //   return ;
  // }
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

// class CupertinoContextMenuDemo extends StatelessWidget {
//   const CupertinoContextMenuDemo({super.key});
// }

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

// ignore: must_be_immutable
class CupertinoContextMenuDemo extends StatefulWidget {
  CupertinoContextMenuDemo(this._imageParent, this.name, {super.key});
  late File _imageParent;
  late String name;
  @override
  State<CupertinoContextMenuDemo> createState() =>
      _CupertinoContextMenuDemoState();
}

class _CupertinoContextMenuDemoState extends State<CupertinoContextMenuDemo> {
  late File _image =
      File("${defoultFilePath!.path}/${widget._imageParent.path}");

  @override
  Widget build(BuildContext context) {
    // final galleryLocalizations = GalleryLocalizations.of(context)!;
    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   automaticallyImplyLeading: false,
      //   middle: Text(''
      //       // galleryLocalizations.demoCupertinoContextMenuTitle,
      //       ),
      // ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: CupertinoContextMenu(
                actions: [
                  ElevatedButton(onPressed: () {}, child: Text('data')),
                  CupertinoContextMenuAction(
                    trailingIcon: Icons.photo_library_outlined,
                    onPressed: () async {
                      // await pickImagefrom();
                      await pickAnImage.pickImagefrom();

                      setState(() {
                        pickedImage = pickAnImage.pickedImage;
                        if (pickAnImage.image != null) {
                          // allowChang = true;

                          _image = pickAnImage.image!;
                          var imagetype = pickAnImage.imageType.split(".").last;
                          imageNewName =
                              "${Jiffy.now().yMd.replaceAll('/', '')}:${Jiffy.now().hour}(${widget.name}).${imagetype}";

                          allowChang = true;
                          print(imageNewName);
                        } else {
                          _image = File(
                              "${defoultFilePath!.path}/${widget._imageParent.path}");
                        }
                      });

                      print(_image.path);
                      print('******************');

                      Navigator.pop(context);
                    },
                    child: Text(
                        '' // galleryLocalizations.demoCupertinoContextMenuActionOne,
                        ),
                  ),
                  CupertinoContextMenuAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                        '' // galleryLocalizations.demoCupertinoContextMenuActionTwo,
                        ),
                  ),
                ],
                child: SysCircularImage(_image, 200, 200, 0, 30),
                // Container(
                //   height: 200,
                //   width: 200,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       image: DecorationImage(
                //         image: FileImage(_image),
                //         onError: (exception, stackTrace) {
                //           FileImage(
                //               File('${defoultFilePath!.path}/defoult.jpg'));
                //         },
                //       )),
                // )
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(30),
          //   child: Text(
          //     '', // galleryLocalizations.demoCupertinoContextMenuActionText,
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
