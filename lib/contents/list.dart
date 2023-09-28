// import 'dart:js_util';

// import 'dart:ffi';

// ignore_for_file: camel_case_types

// import 'package:flutter/gestures.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hesabi_app/contents/Globals.dart';
import 'package:hesabi_app/contents/image_container.dart';
import 'package:hesabi_app/main.dart';
// import 'package:flutter_swipe_action_cell/core/cell.dart';
// import 'package:hesabi_app/DataClass.dart';
import '../pages/contentpage.dart';
import '../models/sqldb.dart';
import '../models/routes.dart';

// import 'package:path/path.dart';
import 'dart:math';

class cardlistFB2 extends StatefulWidget {
  //const cardlistFB2({super.key});
  final int index;
  final int id;
  final String email;
  final String number;
  final String name;
  final File imageUrl;
  final String title;
  final Function() onPressed;

  const cardlistFB2(
      {required this.index,
      required this.id,
      required this.name,
      required this.email,
      required this.number,
      required this.imageUrl,
      required this.title,
      required this.onPressed,
      Key? key})
      : super(key: key);
  @override
  State<cardlistFB2> createState() => _cardlistFB2State();
}

class _cardlistFB2State extends State<cardlistFB2> {
  Color _iconColor = Colors.black54;
  List colorlist = [
    const Color.fromARGB(255, 22, 22, 79),
    const Color.fromARGB(255, 52, 151, 97),
    const Color.fromARGB(255, 215, 228, 115),
    const Color.fromARGB(255, 209, 38, 49),
    const Color.fromARGB(255, 209, 38, 186),
    const Color.fromARGB(255, 38, 155, 209),
    const Color.fromARGB(255, 4, 2, 2),
    const Color.fromARGB(255, 72, 38, 209),
  ];

  SqlDb sqlDb = SqlDb();
  var colorNumber = Random().nextInt(8);

  int i = 0;
  bool pin = false;

  late String Dir = widget.imageUrl.path;

  @override
  Widget build(BuildContext context) {
    print(widget.imageUrl.path);
    print('00000000000000000000000');
    return ListTile(
      //selected: true,
      splashColor: const Color.fromARGB(255, 177, 184, 177),

      onTap: () {
        // splashColor:

        sysRouting(
            context,
            containsPage(
              index: widget.index,
              id: widget.id,
              name: widget.name,
              email: widget.email,
              number: widget.number,
              imageUrl: File("${widget.imageUrl.path}"),
              tableName: 'people',
              title: widget.title,
            ));
      },
      contentPadding: const EdgeInsets.all(2),

      shape: const Border(bottom: BorderSide(color: Colors.black45, width: 1)),
      title: Text(widget.name),
      subtitle: Row(
        children: [
          const Icon(Icons.thumb_up_alt,
              color: Color.fromARGB(255, 57, 63, 184), size: 20),
          const SizedBox(
            width: 3,
          ),
          // Text(widget.likes),
          Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 67, 33, 33),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(width: 4, height: 4),
              )),

          Text(
            widget.title,
            textAlign: TextAlign.right,
          )
        ],
      ),

      trailing: IconButton(
        highlightColor: Colors.white,
        onPressed: () {
          setState(() {
            // i == 0 ? {} : {};
            colorNumber = Random().nextInt(8);

            if (i == 0) {
              _iconColor = colorlist[colorNumber];
              pin = true;
              i++;
            } else {
              _iconColor = Colors.black45;
              pin = true;
              i--;
            }
            // Colors.deepPurpleAccent;
          });
        },
        icon: Icon(
          Icons.push_pin_outlined,
          color: _iconColor,
        ),
      ),

      leading: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SysCircularImage(
            File("${defoultFilePath!.path}/${widget.imageUrl.path}"),
            50,
            50,
            0,
            100),
        // Container(
        //   height: 40,
        //   width: 40,
        //   child:

        // decoration: BoxDecoration(
        //   color: Colors.blue,
        //   shape: BoxShape.circle,
        //   image: DecorationImage(
        //     image:

        //     // FileImage(File("${widget.imageUrl.path}")),
        //     fit: BoxFit.cover,
        //     scale: 0.5,
        //   ),
        // ),
        // ),
      ),
    );
  }

  // Widget _ListTile() {
  //   return
  // }
}

// return SwipeActionCell(

//     // controller: controller,
//     index: widget.index,

//     // Required!
//     key: ValueKey(widget.index),

//     //  Animation default value below
//     deleteAnimationDuration: 400,

//     // selectedForegroundColor: Colors.black.withAlpha(30),
//     trailingActions: [
//       SwipeAction(
//           title: "send to archive",
//           performsFirstActionWithFullSwipe: true,
//           color: Colors.green,
//           nestedAction: SwipeNestedAction(title: "confirm"),
//           icon: Icon(
//             Icons.archive,
//             color: Colors.white,
//           ),
//           onTap: (handler) async {
//             await handler(true);
//             //
//             // list.insert(list,index);
//             setState(() {});
//           }),
//       // SwipeAction(title: "action2", color: Colors.grey, onTap: (handler) {}),
//     ],
//     leadingActions: [
//       SwipeAction(
//           title: "delete",
//           performsFirstActionWithFullSwipe: true,
//           nestedAction: SwipeNestedAction(title: "confirm"),
//           icon: Icon(
//             Icons.delete,
//             color: Colors.white,
//           ),
//           // color: Colors.black,
//           onTap: (handler) async {
//             // splashColor:
//             // const Color.fromARGB(255, 107, 100, 100);
//             // selectedColor:
//             // Colors.green;
//             // selectedTileColor:
//             // Colors.lightBlue;
//             await handler(true);
//             // items.removeAt(index);
//            //? var res = sqlDb.deletData('people', 'id = ${widget.id}');

//             print(res);

//             setState(() {});

//             // Then show a snackbar.
//             //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(

//             //       content:Card(child: Row(children: [IconButton(onPressed: (){}, icon: Icon(Icons.change_circle_outlined)), Text('press to cancel')],),);//Text('${items![index]['name']} dismissed')));
//           }),

//       // SwipeAction(
//       //     title: "action3", color: Colors.orange, onTap: (handler) {}),
//     ],
//     // selectedForegroundColor: InkSplash(controller: , referenceBox: referenceBox, textDirection: textDirection, color: color),
//     child: );
