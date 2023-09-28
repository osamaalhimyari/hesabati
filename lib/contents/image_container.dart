import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hesabi_app/contents/Globals.dart';

class SysCircularImage extends StatefulWidget {
  SysCircularImage(
      this.imageUrl, this.vheit, this.vwidth, this.vmargin, this.vradius,
      {super.key});

  final File imageUrl;
  final double vradius;
  final double vheit;
  final double vwidth;
  final double vmargin;

  @override
  State<SysCircularImage> createState() => _SysCircularImageState();
}

class _SysCircularImageState extends State<SysCircularImage> {
  late bool _loaded = false;

  var path;

  // var placeholder = File('${defoultFilePath!.path}/defooult.jpg');

  check() async {
    if (await widget.imageUrl.exists()) {
      _loaded = true;
      setState(() {});
      // path = File('${defoultFilePath!.path}/${imageUrl.path}');
    }
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // initState();
    return Container(
      margin: EdgeInsets.only(left: widget.vmargin, right: widget.vmargin),
      height: widget.vheit,
      //  padding: EdgeInsets.all(vradius),
      width: widget.vwidth,
      // child: fetchImage(imageUrl),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(widget.vradius),
        // shape: BoxShape.circle,
        image: DecorationImage(
          image: _loaded == false
              ? FileImage(File('${defoultFilePath!.path}/defoult.jpg'))
              : FileImage(widget.imageUrl),

          fit: BoxFit.cover,
          // onError: (exception, stackTrace) =>
          //     stackTrace = File('${defoultFilePath!.path}/defoult.jpg'),

          // File(' /defoult.jpg');
        ),
      ),
    );
  }
}
