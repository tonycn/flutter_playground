import 'package:flutter/material.dart';
import 'package:flutter_playground/sample/overflow_canvas_screen.dart';
import 'package:flutter_playground/sheet/snap_sheet_example_screen.dart';
import 'package:flutter_playground/sample/text_field_test_screen.dart';
import 'package:flutter_playground/sample/transform_screen.dart';

import 'sample/capture_screen.dart';


class HomeTabsScreen extends StatelessWidget {
  const HomeTabsScreen() : super();

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Center(child: TransformScreen()),
      Center(child: CaptureScreen()),
      Center(child: OverflowCanvasScreen()),
      Center(child: SnapSheetExampleScreen(),)
    ];
    return HomeTabsWidget(tabs);
  }
}


class HomeTabsWidget extends StatefulWidget {
  const HomeTabsWidget(this.tabs) : super();
  final List<Widget> tabs;
  @override
  _HomeTabsWidgetState createState() => _HomeTabsWidgetState();
}

class _HomeTabsWidgetState extends State<HomeTabsWidget> {
  static const List<String> titles = [ 'I', 'II', 'III', 'IV', 'V'];

  int index = 0;

  void _onItemTapped(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  Widget currentBodyWidget() {
    return widget.tabs[index];
  }

  @override
  Widget build(BuildContext context) {
    final screen = Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(titles[index], style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: Container(
        child:  currentBodyWidget(),
        color: Theme.of(context).backgroundColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.textsms),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.transform),
            title: Text(''),
          ),
        ],
        currentIndex: index,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.black,

        unselectedFontSize: Theme.of(context).textTheme.button.fontSize,
        selectedFontSize: Theme.of(context).textTheme.button.fontSize,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
      ),
    );

    return screen;
  }
}
