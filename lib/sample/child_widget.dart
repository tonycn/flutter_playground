import 'dart:math';

import 'package:flutter/material.dart';

class ChildWidget extends StatelessWidget {

  const ChildWidget(this.text, {Key key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    print('xxxxxx build $text');
    return ChildStatefulWidget();
  }

}


class ChildStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChildStatefulWidgetState();
  }
}

class _ChildStatefulWidgetState extends State<ChildStatefulWidget> {

  void initState() {
    super.initState();
    cachedWidgets = <Widget>[];
  }

  List<Widget> cachedWidgets;
  static int count = 0;

  @override
  Widget build(BuildContext context) {

    ++count;
    final w = Text('X $count', style: TextStyle(color: Colors.red, fontSize: 14),);
    cachedWidgets.add(w);
    print('xxxxxx build children ${cachedWidgets.length} $count');
    final index = max(cachedWidgets.length-3, 0);
    return Row(children: [cachedWidgets[index]]);
  }

}
