// import 'package:flutter/material.dart';
import 'package:hesabi_app/models/sqldb.dart';

// import 'package:sqflite/sqflite.dart';
SqlDb sqlDb = SqlDb();

class UserModel {
  bool isLoading = true;
  final List users = [];
  List user = [];
  int id = 0;
  late String name;
  late String email;
  late String number;
  late String image;

  Future fetchData() async {
    List<Map> response = await sqlDb.fetchData('user');
    // users.clear();
    users.addAll(response);

    print(users[0]);
    isLoading = false;
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

// class UserAccount extends StatelessWidget {
//   final int userId;
//   Future<List<User>> getUsers() async {
//     final db = await sqlDb.fetchData('user');

//     final List<Map<String, dynamic>> maps = await db.query('user_data');

//     return List.generate(maps.length, (i) {
//       return User.fromMap(maps[i]);
//     });
//   }

//   UserAccount({required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Account'),
//       ),
//       body: FutureBuilder<User>(
//         future: getUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final user = snapshot.data;

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Text('Name: ${user.name}'),
//                 // Text('Email: ${user.email}'),
//               ],
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
