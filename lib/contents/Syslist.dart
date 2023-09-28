// ignore_for_file: file_names, slash_for_doc_comments, avoid_print

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:hesabi_app/contents/dialog.dart';
import 'package:hesabi_app/contents/tools.dart';
import 'package:hesabi_app/main.dart';
// import 'package:hesabi_app/models/routes.dart';
import '../models/sqldb.dart';
import 'list.dart';

int differentLength = 0;

class SysList extends StatefulWidget {
  final bool static;
  const SysList({required this.static, super.key});

  @override
  State<SysList> createState() => _SysListState();
}

List person = [];

class _SysListState extends State<SysList> {
  SqlDb sqlDb = SqlDb();
  bool isLoading2 = true;

  Future fetchData() async {
    List<Map> response = await sqlDb.fetchData('people');
    person.clear();
    person.addAll(response);
    differentLength = person.length;
    isLoading2 = false;
    if (mounted) {
      setState(() {});
    } else {}
  }

  // late SwipeActionController controller;
  @override
  void initState() {
    fetchData();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (person.length < differentLength || person.length == 0) {
        fetchData();
      } else {}
    });
    // print(person.first['imagePath']);

    // Future.delayed(Duration(seconds: 2), () {
    //   setState(() {
    //   // user.isVerified = false;
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading2 == true)
        ? SliverToBoxAdapter(
            child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ))
        : (person.isEmpty || person.length == 0)
            ? SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      SysgreatText(' click to add new friend', 22, Colors.black,
                          FontWeight.bold, 1),
                      SizedBox(
                        height: 30,
                      ),

                      // InkWell(
                      //   onTap: () {
                      IconButton(
                        iconSize: 100,
                        onPressed: () {
                          dialogForm(context);
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Color.fromARGB(255, 57, 39, 176),
                        ),
                      )

                      //   },
                      // ),
                      // TextButton(
                      //   child: Icon(

                      //     size: 100,

                      //   ),
                      //   style: ButtonStyle(
                      //     alignment: Alignment.center,
                      //   ),
                      //   onPressed: () {

                      //   },
                      // )
                    ],
                  ),
                ),
              )
            : SliverList.builder(
                addAutomaticKeepAlives: isLoading2,
                itemCount: person.length,
                itemBuilder: (context, reversedIndex) {
                  final index = person.length - reversedIndex - 1;

                  print('9999999999999999999999');
                  return widget.static == false
                      ? SwapeForList(index)
                      : cardlistFB2(
                          index: index,
                          id: person[index]['id'],
                          name: ' ${person[index]['name']}',
                          email: ' ${person[index]['email']}',
                          number:
                              ' ${person[index]['number']}', //'${person['name']}',
                          imageUrl: File('${person[index]['imagePath']}'),
                          //'${person[index][2]}',
                          title:
                              '${person[index]['title']}', //'${person['title']}' '$index',
                          onPressed: () {},
                        );
                },
              );
  }

  GestureDetector SwapeForList(int index) {
    return GestureDetector(
      onTap: () {},
      child: Dismissible(
          // direction: DismissDirection.endToSta
          onUpdate: (details) {},
          confirmDismiss: (direction) {
            return Future.value(true);
          },

          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key("$index"),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) async {
            // Remove the item from the data source.
            setState(() {
              //  this.(widget.index);
            });
            int holdId = person[index]['id'];

            person.removeAt(index);

            if (direction == DismissDirection.startToEnd) {
              var res = await sqlDb.deletData('people', 'id=$holdId');

              print(
                  '$index =====================delete hrer   $res ==============================');
              setState(() {});

              setState(() {});
            } else {
              setState(() {});
            }

            // Then show a snackbar.
          },
          // Show a red background as the item is swiped away.
          background: swipeAction(
              Colors.red, Icons.delete, 'Delete', MainAxisAlignment.start),
          secondaryBackground: swipeAction(
              Colors.green, Icons.archive, 'Archive', MainAxisAlignment.end),
          child: cardlistFB2(
            index: index,
            id: person[index]['id'],
            name: ' ${person[index]['name']}',
            imageUrl: File('${person[index]['imagePath']}'),
            email: ' ${person[index]['email']}',
            number: ' ${person[index]['number']}', //'${person['name']}',

            //'${person[index][2]}',
            title: '${person[index]['title']}', //'${person['title']}' '$index',
            onPressed: () {},
          )),
    );
  }

  Container swipeAction(Color backgrooundcolor, IconData icon, String text,
      MainAxisAlignment alignment) {
    return Container(
      color: backgrooundcolor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}





//  static const TextTheme whiteCupertino = TextTheme(
//     display4   : TextStyle(debugLabel: 'whiteCupertino display4',   fontFamily: '.SF UI Display', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     display3   : TextStyle(debugLabel: 'whiteCupertino display3',   fontFamily: '.SF UI Display', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     display2   : TextStyle(debugLabel: 'whiteCupertino display2',   fontFamily: '.SF UI Display', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     display1   : TextStyle(debugLabel: 'whiteCupertino display1',   fontFamily: '.SF UI Display', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     headline   : TextStyle(debugLabel: 'whiteCupertino headline',   fontFamily: '.SF UI Display', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     title      : TextStyle(debugLabel: 'whiteCupertino title',      fontFamily: '.SF UI Display', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     subhead    : TextStyle(debugLabel: 'whiteCupertino subhead',    fontFamily: '.SF UI Text',    inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     body2      : TextStyle(debugLabel: 'whiteCupertino body2',      fontFamily: '.SF UI Text',    inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     body1      : TextStyle(debugLabel: 'whiteCupertino body1',      fontFamily: '.SF UI Text',    inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     caption    : TextStyle(debugLabel: 'whiteCupertino caption',    fontFamily: '.SF UI Text',    inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     button     : TextStyle(debugLabel: 'whiteCupertino button',     fontFamily: '.SF UI Text',    inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     subtitle   : TextStyle(debugLabel: 'whiteCupertino subtitle',   fontFamily: '.SF UI Text',    inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     overline   : TextStyle(debugLabel: 'whiteCupertino overline',   fontFamily: '.SF UI Text',    inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//   );



//  static const TextTheme whiteMountainView = TextTheme(
//     display4   : TextStyle(debugLabel: 'whiteMountainView display4',   fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     display3   : TextStyle(debugLabel: 'whiteMountainView display3',   fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     display2   : TextStyle(debugLabel: 'whiteMountainView display2',   fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     display1   : TextStyle(debugLabel: 'whiteMountainView display1',   fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     headline   : TextStyle(debugLabel: 'whiteMountainView headline',   fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     title      : TextStyle(debugLabel: 'whiteMountainView title',      fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     subhead    : TextStyle(debugLabel: 'whiteMountainView subhead',    fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     body2      : TextStyle(debugLabel: 'whiteMountainView body2',      fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     body1      : TextStyle(debugLabel: 'whiteMountainView body1',      fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     caption    : TextStyle(debugLabel: 'whiteMountainView caption',    fontFamily: 'Roboto', inherit: true, color: Colors.white70, decoration: TextDecoration.none),
//     button     : TextStyle(debugLabel: 'whiteMountainView button',     fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     subtitle   : TextStyle(debugLabel: 'whiteMountainView subtitle',   fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//     overline   : TextStyle(debugLabel: 'whiteMountainView overline',   fontFamily: 'Roboto', inherit: true, color: Colors.white,   decoration: TextDecoration.none),
//   );