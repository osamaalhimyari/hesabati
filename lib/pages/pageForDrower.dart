import 'package:flutter/material.dart';
import 'package:hesabi_app/layout/appBar.dart';

class PageForDrower extends StatefulWidget {
  final Widget variablePage;
  const PageForDrower(this.variablePage, {super.key});

  @override
  State<PageForDrower> createState() => _PageForDrowerState();
}

class _PageForDrowerState extends State<PageForDrower> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarFb2(title: 'قائمة الاصدقاء', actions: []),
        body: CustomScrollView(
          slivers: [
            // AdaptiveHeightSliverPersistentHeader(
            //   floating: true,
            //   child: Header(),
            // ),
            widget.variablePage,
          ],
        ));
  }
}
