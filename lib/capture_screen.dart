import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen();

  @override
  State<StatefulWidget> createState() {
    return _CaptureScreenState();
  }
}

class _CaptureScreenState extends State<CaptureScreen> {
  Image image;
  final GlobalKey previewContainer = new GlobalKey();
  static int count = 0;
  final PermissionHandler _permissionHandler = PermissionHandler();

  void _capturePng() async {
    var timeStamp = Timeline.now;
    if (count < 1) {
      print('start capture timeStamp $timeStamp');
    }

    if (image != null) {
      setState(() {
        image = null;
      });
      return;
    }

    try {
      print('_capturePng');
      RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
      ui.Image capturedImage = await boundary.toImage(pixelRatio: 4);
      timeStamp = Timeline.now;
      if (count < 1) {
        print('capturedImage timeStamp $timeStamp');
      }
      ByteData byteData = await capturedImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      if (count < 1) {
        print('pngBytes timeStamp $timeStamp');
      }
      await _save(pngBytes);
      setState(() {
        if (count < 1) {
          print('before image from memory $timeStamp');
        }
        image = Image.memory(pngBytes);
        if (count < 1) {
          print('after image from memory $timeStamp');
        }
      });
      timeStamp = Timeline.now;
      if (count < 1) {
        print('end capture timeStamp $timeStamp');
      }
    } catch (e) {
      print(e);
    }
  }

  _save(Uint8List pngBytes) async {
   final result = await ImageGallerySaver.saveImage(
           pngBytes,
           quality: 95,
           name: "hello");
   print(result);
  }

  _requestPermission() async {
    PermissionGroup permission = PermissionGroup.photos;
    var result = await _permissionHandler.requestPermissions([permission]);
    print(result);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  void initState() {
    super.initState();

    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (count < 1) {
        print('timeStamp $timeStamp');
      }
      ++count;
      if (count > 10) {
        print('timeStamp $timeStamp');
        return;
      }
      _capturePng();
    });


    final testChildren = <Widget>[];
    for (int i = 0; i < 100; ++i) {
      testChildren.add(Positioned(
              top: 50,
              left: 50,
              child: Container(
                width: 200,
                height: 20,
                color: Colors.blue,
                child: Row(children: [
                  Icon(Icons.memory),
                  Icon(Icons.memory),
                  Icon(Icons.memory),
                  Icon(Icons.memory),
                ],),
              )),);
    }

    final aContainer = Container(
      width: 150,
      height: 200,
      color: Colors.yellowAccent,
      child: Stack(
        children: [
          Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  count = 0;
                  _capturePng();
                },
                child: Text('To capture $count'),
              )),

          ...testChildren
        ],
      ),
    );

    final repaint = RepaintBoundary(key: previewContainer, child: aContainer);

    return Column(
      children: [
        repaint,
        Container(
          width: 200,
          height: 100,
          color: Colors.blue,
          child: image ?? Container(),
        )
      ],
    );
  }
}
