import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:simple_animations/animation_controller_extension/animation_controller_extension.dart';

late Directory? defoultFilePath;
late int didchanges;
Image fetchImage(File gavinImage) {
  Image image;

  image = Image.file(File('${defoultFilePath!.path}/${gavinImage.path}'),
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
    return image = Image.file(File('${defoultFilePath!.path}/defoult.jpg'));
  });

  return image;
}
