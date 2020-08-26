
import 'package:flutter/material.dart';

class CustomLayout extends StatefulWidget {

  const CustomLayout();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomLayoutState();
  }
}

class _CustomLayoutState extends State<CustomLayout> {


  @override
  Widget build(BuildContext context) {
    final tapGesture = GestureDetector(
      onTap: () {
        print('onTap');
      },
      child: Center(child: Container(width: 50, height: 50, color: Colors.blueGrey,),),
    );

    final ignorePointer = IgnorePointer(child: Container(width: 100, height: 100, color: Colors.white, child: tapGesture,),);

    final stack = Stack(
      children: [Positioned(left: 10, top: 10, child: ignorePointer)],
    );
    return Column(children: [
      Container(width: 300, height: 300, color: Colors.amberAccent,child: stack,)
    ],);
  }
}
