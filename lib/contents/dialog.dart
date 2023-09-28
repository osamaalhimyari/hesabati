// ignore_for_file: use_key_in_widget_constructors, annotate_overrides

// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

import 'form.dart';

Future dialogForm(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    // barrierColor: Colors.red,
    context: context,
    builder: (BuildContext context) {
      // Decoration();
      return AlertDialog(
          title: const Text('Container Tapped'),
          content: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[SystemInsertForm()],
          )));

      //     SystemInsertForm()
    },
  );
}
