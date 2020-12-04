
import 'package:flutter/material.dart';

class TextFieldTestScreen extends StatefulWidget {

  const TextFieldTestScreen();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TextFieldTestSState();
  }

}

class _TextFieldTestSState extends State<TextFieldTestScreen> {

  TextEditingController _controller = TextEditingController();

  final GlobalKey _globalKey = GlobalKey();

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
    _controller.text = 'Tap to edit text';
    final stack2 = Stack(
      children: [Positioned(left: 10, top: 50, child: Container(
        width: 200,
        height: 50,
        color: Colors.yellow,
        child: TextField(
          enabled: true,
          style: TextStyle(fontSize: 15, color: Colors.orange),
          controller: _controller,

          onSubmitted: (String value) async {
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) {

              print('_globalKey $_globalKey, ${_globalKey.currentWidget}, ${_globalKey.currentContext}');

              return AlertDialog(
                title: const Text('Thanks!'),
                content: Text ('You typed "$value".'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () { Navigator.pop(context); },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },


        ),
      ))],
    );

    return Column(children: [
      Container(key:_globalKey, width: 300, height: 100, color: Colors.amberAccent,child: stack,),
      Container(width: 300, height: 200, color: Colors.amberAccent,child: stack2,)
    ],);
  }
}
