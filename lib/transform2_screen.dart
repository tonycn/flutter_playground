import 'dart:math';

import 'package:flutter/material.dart';

class LocalCoordinateInfo {
  const LocalCoordinateInfo(this.localRect, this.localTransform, this.localAlignment);
  final Rect localRect;
  final Matrix4 localTransform;
  final Alignment localAlignment;

  @override
  String toString() {
    return 'rect $localRect, localTransform $localTransform';
  }
}


extension RectEx on Rect {
  Offset get middle {
    return Offset(left + width / 2, top + height / 2);
  }
}

extension GlobalKeyEx on GlobalKey {
  Rect get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject() as RenderBox;
    var translation = renderObject?.getTransformTo(null)?.getTranslation();
    final globalMiddle = renderObject?.localToGlobal(renderObject.paintBounds.middle);
    print('globalMiddle $globalMiddle');

    if (translation != null && renderObject.paintBounds != null) {
      print('translation $translation ${renderObject.paintBounds}');
      return renderObject.paintBounds.shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }

  Matrix4 get globalTransform {
    final renderObject = currentContext?.findRenderObject();
    return renderObject?.getTransformTo(null);
  }

  LocalCoordinateInfo convertTo(GlobalKey other) {

//    final matrix4 = Transform.rotate(angle: pi/2).transform;
//    final rotation = matrix4.getRotation();
//    print('matrix4 $matrix4 rotation $rotation');

    final selfRect = globalPaintBounds;
    final selfWidget = currentContext?.widget as Container;
    final selfTranslation = currentContext?.findRenderObject()?.getTransformTo(null)?.getTranslation();
    final selfAlignment = (selfWidget.alignment as Alignment) ?? Alignment.center;
    final selfAlignmentPos = selfRect.middle + Offset(selfAlignment.x * selfRect.width / 2, selfAlignment.y * selfRect.height / 2);
    print('globalPaintBounds $globalPaintBounds selfAlignmentPos $selfRect $selfAlignmentPos selfTranslation: $selfTranslation');

    final otherRenderObject = other?.currentContext?.findRenderObject() as RenderBox;
    var localOrigin = otherRenderObject?.globalToLocal(Offset(selfRect.left, selfRect.top));
    var localAlignmentPos = otherRenderObject?.globalToLocal(selfAlignmentPos);

    var localSize = Size(selfRect.width, selfRect.height);
    final otherTransform = other?.globalTransform;


    final selfTransform = globalTransform;

//    print('otherTransform $otherTransform');
    final localTransform = selfTransform * Matrix4.inverted(otherTransform);

    final localRect = Rect.fromLTWH(localOrigin.dx, localOrigin.dy, localSize.width, localSize.height);
    final localAlignment = Alignment(
        (localAlignmentPos.dx - localRect.middle.dx) / (localRect.width / 2),
        (localAlignmentPos.dy - localRect.middle.dy) / (localRect.height / 2));
    print('$localRect localAlignment $localAlignment ( $localAlignmentPos )');
    final tmp = Alignment(-1.08, -1.54);
    return LocalCoordinateInfo(localRect, localTransform,  localAlignment);
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
            scale: 1,
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
                      angle: pi / 4,
                      child: GestureDetector(
                          onTap: () {
                            print('normalKey ${normalKey.globalPaintBounds}');
                            print('end normalKey');

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
//      print('LocalCoordinateInfo \n $_coordinateInfo');
      final stack = Stack(
        children: [
          Positioned(
              left: _coordinateInfo.localRect.left,
              top: _coordinateInfo.localRect.top,
              child: IgnorePointer(
                  child: Container(
                width: _coordinateInfo.localRect.width,
                height: _coordinateInfo.localRect.height,
                color: Colors.red,
              )))
        ],
      );

      container2 = Transform(
        alignment: _coordinateInfo.localAlignment,
        transform: _coordinateInfo.localTransform,
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
          key: container2Key,
          left: 0,
          top: 0,
          bottom: 0,
          right: 0,
          child: IgnorePointer(
            child: container2,
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
