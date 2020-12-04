import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SnapSheetExampleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _SnapSheetExampleScreenState();
  }



}

class _SnapSheetExampleScreenState extends State<SnapSheetExampleScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
            body: SnappingSheet(
                    sheetBelow: SnappingSheetContent(
                        child: Container(
                            color: Colors.red,
                        ),
                        heightBehavior: SnappingSheetHeight.fit()),
                    snapPositions: const [SnapPosition(positionFactor: 0.2),
                      SnapPosition(positionFactor: 0.5),
                      SnapPosition(positionFactor: 0.9),
                      ],
                    grabbingHeight: 30,
                    grabbing: Container(
                        color: Colors.blue,
                    ),
                ),
            );
  }

}