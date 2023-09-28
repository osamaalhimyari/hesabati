// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hesabi_app/contents/Globals.dart';
import 'package:hesabi_app/contents/image_container.dart';
import 'package:hesabi_app/main.dart';
// import 'package:hesabi_app/contents/image_container.dart';
// import 'package:hesabi_app/contents/tools.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import '../models/sqldb.dart';
import '../pages/homepage.dart';
import '../contents/Syslist.dart';

import 'dart:core';

// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class SystemInsertForm extends StatefulWidget {
  SystemInsertForm({super.key});

  @override
  State<SystemInsertForm> createState() => _SystemInsertFormState();
}

class _SystemInsertFormState extends State<SystemInsertForm> {
  SqlDb sqlDb = SqlDb();

  final GlobalKey<FormState> formstate = GlobalKey();

  final TextEditingController name = TextEditingController();

  final TextEditingController title = TextEditingController();

  final TextEditingController imagePath = TextEditingController();

  final TextEditingController number = TextEditingController();

  // GetImage getimage = GetImage();

  // var imagep;
  var pickedImage;
  var _image = File("${defoultFilePath!.path}/defoult.jpg");
  String imageType = '';
  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    _pickImageFromGallery() async {
      pickedImage =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

      if (pickedImage == null) return;

      File image =
          File(pickedImage.path); // this just to show it teprary befor saveing
      imageType = basename(pickedImage.path).split(".").last;

      // print('$imageType');
      // print('=====-=-=--------=====');

      setState(() {
        _image = image;
      });
    }

    // var image2;

    return SizedBox(
      height: 400,
      child: Form(
          key: formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Builder(builder: (context) {
                      return InkWell(
                          onTap: (() {
                            // up();
                            _pickImageFromGallery();
                          }),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  child:
                                      SysCircularImage(_image, 100, 100, 2, 50)
                                  // fetchImage(_image),
                                  )));
                      // SysCircularImage(_image, 100, 100, 0, 50)
                    }),
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(hintText: 'name'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(hintText: 'title'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: number,
                      decoration: const InputDecoration(hintText: 'number'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: imagePath,
                    //   decoration: const InputDecoration(hintText: 'imagePath'),
                    //   validator: (String? value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter some text';
                    //     }
                    //     return null;
                    //   },
                    // ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      if (formstate.currentState!.validate()) {
                        String imagePath = "defoult.jpg";
                        if (pickedImage != null) {
                          imagePath =
                              "${Jiffy.now().yMd.replaceAll('/', '')}:${Jiffy.now().hour}(${name.text}).${imageType.split(".").last}";
                          pickedImage
                              .saveTo("${defoultFilePath!.path}/$imagePath");
                        }
                        int response = await sqlDb.insertData('people', {
                          'name': name.text,
                          'title': title.text,
                          'number': number.text,
                          'imagePath': imagePath,
                          'dateAdding':
                              "${Jiffy.now().yMEd}:${Jiffy.now().hour}",
                          'dateModify':
                              "${Jiffy.now().yMEd}:${Jiffy.now().hour}"
                        });

                        Navigator.pop(context, const Homepage());
                        differentLength++;

                        /**?                      */
                        print('$response added ===================');
                      } else {
                        print('noo ================');
                      }
                    },
                    child: const Text('Add'),
                  ),
                  SizedBox(width: 10),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Cancle'),
                    onPressed: () async {
                      Navigator.pop(context, const Homepage());

                      /**?                      */
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
// late File image;
// final imagePicker = ImagePicker();
// Future<dynamic> UploadImage() async {
//   var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
//   if (pickedImage != null) {
//     image = File(pickedImage.path);

    // Directory? getDirector = await getExternalStorageDirectory();
    // File file =
    //     File(path.join(getDirector!.path, path.basename(/** uri */)));
    //     await file.writeAsBytes(pickedImage.bodybytes)
//     print('');
//     // print();
//     print('========================');
//   } else {}
// }

//   Future<dynamic> up() async {
//       image2 = (await ImagePicker().pickImage(source: ImageSource.gallery));
// // Step 2: Check for valid file
//       if (image2 == null) return;
// // Step 3: Get directory where we can duplicate selected file.
//       final Directory? duplicateFilePath = Platform.isAndroid
//           ? await getExternalStorageDirectory()
//           : await getApplicationDocumentsDirectory();
// // Step 4: Copy the file to a application document directory.
//       final String fileName = basename(image2.path);
//       // var localImage = image2.saveTo('/storage/emulated/0/hesabiApp/$fileName');

//       setState(() {
//         //  imagep = "${duplicateFilePath!.path}${basename(image2.path)}";
//       });
//     }

