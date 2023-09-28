import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hesabi_app/contents/Globals.dart';
import 'package:hesabi_app/contents/Syslist.dart';
import 'package:hesabi_app/contents/image_container.dart';
// import 'package:hesabi_app/contents/image_container.dart';
import 'package:hesabi_app/contents/theme.dart';
import 'package:hesabi_app/main.dart';
import 'package:hesabi_app/pages/pageForDrower.dart';
import '../models/select.dart';
import '../pages/DetailsPage.dart';
// import '../contents/tools.dart';
import '../models/routes.dart';
// import '../contents/image_container.dart';

// import 'package:hesabi_app/DataClass.dart';

class DrawerFb2 extends StatelessWidget {
  const DrawerFb2(
      this.index, this.id, this.name, this.email, this.number, this.imageUrl,
      {super.key});
  final int index;
  final int id;
  final String name;
  final String email;
  final String number;
  final File imageUrl;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: MyThemes.primaryColor,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                      accountName: Text(name),
                      accountEmail: Text(email),
                      currentAccountPicture: InkWell(
                        onTap: () {
                          sysRouting(
                              context,
                              detailspage(index, id, name, email, number,
                                  File(imageUrl.path), 'user', 'nothing'));

                          print("$name ==================");
                        },
                        child: SysCircularImage(
                            File("${defoultFilePath!.path}/${imageUrl.path}"),
                            50,
                            50,
                            0,
                            50),

                        //  SysCircularImage(File(""), 100, 100, 0, 50)
                        // ClipOval(
                        //   child: fetchImage(File(imageUrl.path)),
                        //   // Image.file(
                        //   //  ,
                        //   //   fit: BoxFit.cover,
                        //   //   width: 150,
                        //   //   height: 150,
                        //   //   alignment: Alignment.centerLeft,
                        //   // ),
                        // ),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(27, 30, 92, 0.6),
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //    image: AssetImage("images/$imageUrl"),
                        //   opacity: 100,
                        // ),
                      ),
                      onDetailsPressed: () {
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.red,
                        );
                      }),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 12),
                  // SysMenuItem(context, 0),
                  MenuItem(
                    text: 'frieds',
                    icon: Icons.people,
                    onClicked: () {
                      sysRouting(context, PageForDrower(SysList(static: true)));
                    },
                  ),
                  const SizedBox(height: 5),
                  MenuItem(
                    text: 'Liked Photos',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 5),
                  MenuItem(
                    text: 'Workflow',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 5),
                  MenuItem(
                    text: 'Updates',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 8),
                  MenuItem(
                    text: 'Notifications',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  MenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => sysRouting(context, const SqlComands()),
                    // selectedItem(context, 6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Scaffold(), // Page 1
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Scaffold(), // Page 2
        ));
        break;
    }
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onClicked;

  const MenuItem({
    required this.text,
    required this.icon,
    this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

class UserIcon extends StatelessWidget {
  const UserIcon(this.imageurl, {Key? key}) : super(key: key);
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage(imageurl), fit: BoxFit.cover),
      ),
    );
  }
}


// class SearchFieldDrawer extends StatelessWidget {
//   const SearchFieldDrawer({Key? key}) : super(key: key);

   //   @override
//   Widget build(BuildContext context) {
//     final color = Colors.white;

  //     return TextField(
//       style: TextStyle(color: color, fontSize: 14),
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//         hintText: 'Search',
//         hintStyle: TextStyle(color: color),
//         prefixIcon: Icon(
//           Icons.search,
//           color: color,
//           size: 20,
//         ),
//         filled: true,
//         fillColor: Colors.white12,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: color.withOpacity(0.7)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide(color: color.withOpacity(0.7)),
//         ),
//       ),
//     );
//   }
// }
