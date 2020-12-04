import 'package:flutter/material.dart';

class GestureTestScreen extends StatefulWidget {
  const GestureTestScreen();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GestureTestScreenState();
  }
}

class _GestureTestScreenState extends State<GestureTestScreen> {
  @override
  Widget build(BuildContext context) {
    final tapGesture = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        print('onTap 1');
      },
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          color: Colors.blueGrey,
        ),
      ),
    );

    final ignorePointer = IgnorePointer(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.white,
        child: tapGesture,
      ),
    );

    final tapGesture2 = GestureDetector(
      onTap: () {
        print('onTap 2');
      },
      child: Center(
        child: Container(
          width: 150,
          height: 150,
          color: Colors.pink,
        ),
      ),
    );

    final container3 = Container(
          width: 50,
          height: 50,
          color: Colors.cyanAccent,
      child: Center(child: Text('Text')),
        );
    final stack = Stack(
      children: [
        Positioned(left: 100, top: 100, child: tapGesture2),
        Positioned(left: 10, top: 10, child: container3)
      ],
    );
    return Column(
      children: [
        Container(
          width: 300,
          height: 300,
          color: Colors.amberAccent,
          child: Center(child: stack,),
        )
      ],
    );
  }
}
