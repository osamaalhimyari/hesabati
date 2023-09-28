// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import '../models/sqldb.dart';
// import '../body.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  get searchController => null;

  get hintText => null;
  int i = 0;
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    // v1 = context;
    return Container(
      height: (MediaQuery.of(context).size.height) / 4,
      width: (MediaQuery.of(context).size.height),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 50,
            blurStyle: BlurStyle.inner,
            color: Color.fromARGB(255, 42, 25, 102),
            spreadRadius: 1,
            // inset: true,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: (MediaQuery.of(context).size.height) / 4,
        width: (MediaQuery.of(context).size.height),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
        margin: const EdgeInsets.fromLTRB(2, 2, 2, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          verticalDirection: VerticalDirection.down,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: containerDash(
                        colorIcon: Colors.green,
                        icon: Icons.arrow_circle_up_rounded,
                        money: 00.0),
                  ),
                  Expanded(
                    child: containerDash(
                        colorIcon: Colors.red,
                        icon: Icons.arrow_circle_down_rounded,
                        money: 00.0),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
              width: double.infinity,
            ),
            Expanded(
              flex: 1,
              child: SearchInputFb2(
                  searchController: TextEditingController(),
                  hintText: 'ابحث بالاسم'),
            )
          ],
        ),
      ),
    );
  }
}

class containerDash extends StatefulWidget {
  final IconData icon;
  final double money;
  final Color colorIcon;
  const containerDash(
      {required this.icon,
      required this.money,
      required this.colorIcon,
      super.key});
  @override
  State<containerDash> createState() => _containerDashState();
}

class _containerDashState extends State<containerDash> {
  late bool visible = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("hello tow");
        setState(() {
          visible = !visible;
        });
      },
      child: Stack(
        children: [
          const Card(
            child: Text('hello world'),
          ),
          AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 21, 3, 21),
                child: Row(
                  children: [
                    Icon(
                      widget.icon,
                      color: widget.colorIcon,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      '${widget.money}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 33, 29, 29),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchInputFb2 extends StatefulWidget {
  final TextEditingController searchController;
  final String hintText;

  const SearchInputFb2(
      {required this.searchController, required this.hintText, Key? key})
      : super(
          key: key,
        );

  @override
  State<SearchInputFb2> createState() => _SearchInputFb2State();
}

class _SearchInputFb2State extends State<SearchInputFb2> {
  final primaryColor = const Color(0xff4338CA);

  final secondaryColor = const Color(0xff6D28D9);

  final accentColor = const Color(0xffffffff);

  final backgroundColor = const Color(0xffffffff);

  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xff4338CA), Color(0xff6D28D9)]),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
      child: TextField(
        controller: widget.searchController,
        textAlign: TextAlign.center,
        onChanged: (value) {},
        style: TextStyle(fontSize: 14, color: accentColor),
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.email),
          prefixIcon: Icon(Icons.search, size: 20, color: accentColor),
          filled: true,
          fillColor: Colors.transparent,
          // hintText: hintText,
          // hintStyle: TextStyle(color: accentColor.withOpacity(.75)),
          labelText: widget.hintText,
          labelStyle: TextStyle(color: accentColor.withOpacity(.40)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.5, horizontal: 20.0),
          enabled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 47, 183, 20), width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 184, 35, 35), width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 36, 56, 173), width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
////////////




/**
 * 
 * 
 * 
 * 
 * 
 *     Container(
              height: 100,
              width: 100,
              color: Colors.blue,
              child: MaterialButton(
                height: 5,
                onPressed: () async {
                  int response = await sqlDb.updatehData(
                      'people', {'imagepath': "2.jpeg"}, 'id=2');
                  //     '''
                  //  UPDATE "notes" SET "title" ="even note" WHERE id =2 or id=4
                  //  ''');
                  //           print(response);

                  // List<Map> response = await sqlDb.fetchData('people');
                  // print(response);

                  // await sqlDb.deleteMyDataBase();
                  //
                  // int response = await sqlDb.insertData('people', {
                  //   'name': "mari",
                  //   'title': "friend",
                  //   'number': "7777777",
                  //   'imagepath': "9.jpeg",
                  //   'dateAdding': "2023/09/5",
                  //   'dateModify': "2023/09/5",
                  // });

                  // people = [
                  //   {'name': 'loyes', 'job': 'police man', 'image': '0.jpg'},
                  //   {'name': 'martin', 'job': 'SEO', 'image': '1.jpg'},
                  //   {'name': 'symon', 'job': 'manager', 'image': '3.jpg'},
                  //   {'name': 'sosan', 'job': 'marketer', 'image': '4.jpg'},
                  //   {'name': 'jemy', 'job': 'developer', 'image': '5.jpg'},
                  //   {'name': 'natali', 'job': 'doctor', 'image': '6.jpg'},
                  //   {'name': 'max', 'job': 'saler', 'image': '7.jpg'},
                  //   {'name': 'lena', 'job': 'dentist', 'image': '8.jpg'},
                  //   {'name': 'mari', 'job': 'pharmasist', 'image': '9.jpg'},
                  // ];

                  ///
                  // if (response > 0) {
                  //   setState(() {});
                  // }
                  // print(response);
                },
                color: Colors.red,
                textColor: Colors.white,
                child: Text('insert data'),
              ),
            ),
       
 */