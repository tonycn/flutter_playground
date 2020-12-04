import 'dart:math';

import 'package:flutter/material.dart';

class TransformScreen extends StatelessWidget {
  const TransformScreen();
  @override
  Widget build(BuildContext context) {
    final content01 = Container(
      color: Colors.blue.withOpacity(0.4),
      width: 200,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 50,
            child: Text('Text Text'),
          )
        ],
      ),
    );
    final content0 = Container(
        color: Colors.pink.withOpacity(0.4),
        width: 200,
        height: 100,
        child: Transform.scale(
            alignment: Alignment.topLeft,
            scale: 0.5,
            child: Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                child: content01,
              )
            ])));
    final content1 = Container(
      color: Colors.blue.withOpacity(0.4),
      width: 50,
      height: 50,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Text('Text Text'),
          )
        ],
      ),
    );
    final content2 = Container(
      color: Colors.yellow.withOpacity(0.4),
      width: 200,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 50,
            child: Text('Text Text'),
          )
        ],
      ),
    );

    final content21 = Container(
      color: Colors.yellowAccent.withOpacity(0.4),
      width: 200 * 2.0,
      height: 100 * 2.0,
      child: Stack(
        children: [
          Positioned(
            top: 50 * 2.0,
            left: 50 * 2.0,
            child: Text('Text Text'),
          )
        ],
      ),
    );

    final content3 = Container(
      color: Colors.blueGrey.withOpacity(0.4),
      width: 200,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 50,
            child: Text('Text Text'),
          )
        ],
      ),
    );
    final content4 = Container(
      color: Colors.cyan.withOpacity(0.4),
      width: 200,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 50,
            child: Text('Text Text'),
          )
        ],
      ),
    );

    final angle = pi / 2;
    final rotateStackSampleWidget = Container(
        width: 200,
        height: 100,
        color: Colors.black26,
        child: Transform.rotate(
            angle: 0,
            child: Stack(children: [
              Positioned(
                  top: 0,
                  left: 0,
                  child: Center(
                      child: Transform.rotate(alignment: Alignment.center, angle: 0, child: Text('Rotated Text'))))
            ])));

    final col = Column(
      children: [
        content0,
        Transform.rotate(angle: pi / 2, child: content3),
        Container(color: Colors.black.withOpacity(0.4), width: 200, height: 100),
        Container(
          color: Colors.orange.withOpacity(0.4),
          width: 200,
          height: 100,
          child: OverflowBox(
            minWidth: 200,
            minHeight: 100,
            maxWidth: 400,
            maxHeight: 200,
            child: Transform.scale(
                origin: Offset.zero,
                alignment: Alignment.center,
                scale: 0.5,
                child: Stack(
                  children: [
                    Positioned(
                        left: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            print('on tap scaled');
                          },
                          child: Container(
                              color: Colors.blueGrey.withOpacity(0.8),
                              width: 200 * 2.0,
                              height: 100 * 2.0,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: GestureDetector(
                                        onTap: () {
                                          print('on tap text');
                                        },
                                        child: Text('Hello',)),
                                  )
                                ],
                              )),
                        ))
                  ],
                )),
          ),
        ),
        rotateStackSampleWidget,
      ],
    );

    return GestureDetector(child: col, onTap: () {
      print('on tap column');
    },);
  }
}
