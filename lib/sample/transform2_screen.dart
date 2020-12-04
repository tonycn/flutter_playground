import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

class LocalCoordinateInfo {
  const LocalCoordinateInfo(this.localRect, this.localRotation);
  final Rect localRect;
  final Matrix4 localRotation;

  @override
  String toString() {
    return 'localRect $localRect, localRotate $localRotation';
  }
}


extension RectEx on Rect {
  Offset get middle {
    return Offset(left + width / 2, top + height / 2);
  }
}

extension MatrixEx on Matrix4 {
  vector_math.Vector3 get scaleFactor {

    final double scaleXSq = storage[0] * storage[0] +
        storage[1] * storage[1] +
        storage[2] * storage[2];
    final double scaleYSq = storage[4] * storage[4] +
        storage[5] * storage[5] +
        storage[6] * storage[6];
    final double scaleZSq = storage[8] * storage[8] +
        storage[9] * storage[9] +
        storage[10] * storage[10];
    return vector_math.Vector3(sqrt(scaleXSq), sqrt(scaleYSq), sqrt(scaleZSq));
  }
}

extension GlobalKeyEx on GlobalKey {

  Rect get globalRect {
    final renderObject = currentContext?.findRenderObject() as RenderBox;
    final rect = renderObject.paintBounds;
    final globalMiddle = renderObject?.localToGlobal(rect.middle);
    final globalLeftTop = renderObject?.localToGlobal(Offset.zero);
    final globalRightTop = renderObject?.localToGlobal(Offset(rect.width, 0));
    final globalLeftBottom = renderObject?.localToGlobal(Offset(0, rect.height));
    final globalWidth = (globalRightTop - globalLeftTop).distance.abs();
    final globalHeight = (globalLeftBottom - globalLeftTop).distance.abs();

    print('globalWidth $globalWidth globalHeight $globalHeight globalLeftTop $globalLeftTop, globalRightTop ($globalRightTop), globalLeftBottom ($globalLeftBottom), box size (${renderObject.size})');

    print('globalMiddle $globalMiddle, globalWidth ($globalWidth), globalHeight ($globalHeight), box size (${renderObject.size})');
    final localRect = Rect.fromLTWH(globalMiddle.dx - globalWidth/2, globalMiddle.dy - globalHeight/2, globalWidth, globalHeight);
    print('localRect $localRect');
    return localRect;
  }

  Matrix4 get globalRotation {
    final renderObject = currentContext?.findRenderObject() as RenderBox;
    final transform = renderObject?.getTransformTo(null);
    final rotation = transform.getRotation();
    final scale = transform.scaleFactor;
    print('scale $scale');
    rotation.setColumns(rotation.getColumn(0)/scale.x, rotation.getColumn(1)/scale.y, rotation.getColumn(2)/scale.z);
    final rotationMatrix4 = Matrix4.identity();
    rotationMatrix4.setRotation(rotation);

    return rotationMatrix4;
  }

  LocalCoordinateInfo convertTo(GlobalKey other) {

    final selfRect = globalRect;
    final selfRotation = globalRotation;

    final localRenderObject = other?.currentContext?.findRenderObject() as RenderBox;
    final localTopLeft = localRenderObject.globalToLocal(selfRect.topLeft);
    final localBottomRight = localRenderObject.globalToLocal(selfRect.bottomRight);

    return LocalCoordinateInfo(
        Rect.fromLTRB(
            localTopLeft.dx,
            localTopLeft.dy,
            localBottomRight.dx,
            localBottomRight.dy),
        selfRotation);
  }
}

class Transform2Screen extends StatefulWidget {
  const Transform2Screen();

  @override
  State<StatefulWidget> createState() {
    return Transform2ScreenState();
  }
}

class Transform2ScreenState extends State<Transform2Screen> {
  Transform2ScreenState();
  final GlobalKey container1Key = GlobalKey();
  final GlobalKey contentKey = GlobalKey();
  final GlobalKey normalKey = GlobalKey();

  final GlobalKey container2Key = GlobalKey();

  Container transformedContent;
  LocalCoordinateInfo _coordinateInfo;

  @override
  Widget build(BuildContext context) {

    transformedContent = Container(
        key: contentKey,
        color: Colors.pink,
        width: 100 * 2.0,
        height: 50 * 2.0,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                    'Hello',
                    style: TextStyle(fontSize: 50),
                  ),
            )
          ],
        ));

    final normalContent = Container(
      key: normalKey,
        color: Colors.pink,
        width: 100 * 2.0,
        height: 50 * 2.0,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                    'Hello',
                    style: TextStyle(fontSize: 50, color: Colors.yellow),
                  ),
            )
          ],
        ));


    final container1 = Container(
      key: container1Key,
      color: Colors.orange.withOpacity(0.4),
      width: 200,
      height: 100,
      child: OverflowBox(
        minWidth: 200,
        minHeight: 50,
        maxWidth: 400,
        maxHeight: 200,
        child: Transform.scale(
            transformHitTests: true,
            origin: Offset.zero,
            alignment: Alignment.center,
            scale: 1.2,
            child: Stack(
              children: [
                Positioned(
                  left: 50,
                  top: 50,
                  child: normalContent,
                ),
                Positioned(
                  left: 50,
                  top: 50,
                  child: Transform.rotate(
                      angle: pi/8,
                      child: GestureDetector(
                          onTap: () {
                            print('normalKey ${normalKey.globalRect}');
                            final normalInfo = contentKey.convertTo(normalKey);
                            print('end normalKey, normalInfo $normalInfo');
                            print('\n\n');
                            print('on tap text in $transformedContent');
//                            print(' tap  widget ${contentKey.currentWidget}, ${Colors.blueAccent}');
//                            print(" tap  widget rect "
//                                "${contentKey.globalPaintBounds}, "
//                                "\n${contentKey.globalTransform}, "
//                                "${container1Key.globalPaintBounds} ${Colors.blueAccent}");

                            final info = contentKey.convertTo(container2Key);
                            setState(() {
                              if (_coordinateInfo != null) {
                                _coordinateInfo = null;
                              } else {
                                _coordinateInfo = info;
                              }
                            });
                          },
                          child: transformedContent)),
                )
              ],
            )),
      ),
    );

    Widget container2 = Container(
      color: Colors.transparent,
    );

    if (_coordinateInfo != null) {
      print('_coordinateInfo != null LocalCoordinateInfo \n $_coordinateInfo');
      final stack = Stack(
        children: [
          Positioned(
              left: _coordinateInfo.localRect.left,
              top: _coordinateInfo.localRect.top,
              child: IgnorePointer(
                  child: Transform(transform: _coordinateInfo.localRotation, alignment: Alignment.center, child:Container(
                width: _coordinateInfo.localRect.width,
                height: _coordinateInfo.localRect.height,
                color: Colors.blue,
              ))))
        ],
      );

      container2 = Container(
        child: stack,
      );
    }

    final col = Stack(
      children: [
        Positioned(
          left: 10,
          right: 10,
          top: 80,
          child: GestureDetector(
            onTap: () {
              print('on tap container1');
            },
            child: container1,
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          right: 0,
          child: IgnorePointer(
            child: Transform.scale(scale: 2, child:Container(
              key: container2Key,
              child: container2,
            )),
          ),
        )
      ],
    );

    return GestureDetector(
      child: col,
      onTap: () {
        print('on tap column');
      },
    );
  }
}
