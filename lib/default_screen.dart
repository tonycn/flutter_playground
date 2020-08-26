

import 'package:flutter/material.dart';

import 'child_widget.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen();
  @override
  State<StatefulWidget> createState() {
    return _DefaultScreenState();
  }
}

class _DefaultScreenState extends State<DefaultScreen> {
  int _counter;
  @override
  Widget build(BuildContext context) {

    final key2 = 'Key2';
    final key3 = 'Key3';

    return  Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 40,
              child: const ChildWidget('Hello K1'),
            ),
            Container(
              width: 100,
              height: 40,
              child: const ChildWidget('Hello K1'),
            ),
            Container(
              width: 100,
              height: 40,
              child: ChildWidget('Hello K2', key: ValueKey(key2)),
            ),
            Container(
              width: 100,
              height: 80,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _counter += 1;
                  });
                },
                child: Container(
                  width: 100,
                  height: 80,
                  child: ChildWidget('Hello K3', key: ValueKey(key3)),
                ),
              ),
            ),
            Container(
              width: 400,
              height: 40,
              color: Colors.blue,
              child: Stack(
                children: [
                  Positioned(
                      left: 50,
                      top: 50,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(width: 40, height: 40, color: Colors.yellowAccent),
                              left: 10,
                              top: 10,
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Container(
              width: 200,
              height: 50,
              child: Transform.rotate(
                alignment: Alignment.center,
                angle: 0,
                child: Container(
                  width: 400,
                  height: 200,
                  color: Colors.purple,
                  child: Stack(
                    children: [
                      Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(width: 140, height: 140, color: Colors.yellowAccent, child: Text('Text Text'),),
                                left: 10,
                                top: 5,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 50,
              color: Colors.red,
              child: Transform.scale(
                  scale: 0.5,
                  child: Container(
                    child: Text(
                      'XYZ',
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
            Container(
              width: 200,
              height: 50,
              color: Colors.blueGrey,
              child: Transform.scale(
                  scale: 1.5,
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                      'XYZ',
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        );
  }

}