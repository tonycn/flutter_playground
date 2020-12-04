import 'package:flutter/material.dart';

class OverflowCanvasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      constraints: BoxConstraints.expand(),
      child: OverflowBox(
        minHeight: 100,
        minWidth: 100,
        maxHeight: 1000000000,
        maxWidth: 1000000000,
        child: Container(
          color: Colors.red,
          width: 100000000,
          height: 100000000,
        ),
      ),
    );
  }

}