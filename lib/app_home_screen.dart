import 'package:flutter/material.dart';
import 'package:flutter_playground/default_screen.dart';
import 'package:flutter_playground/gesture_test_screen.dart';
import 'package:flutter_playground/transform_screen.dart';

import 'capture_screen.dart';


class HomeTabsScreen extends StatelessWidget {
  const HomeTabsScreen() : super();

  @override
  Widget build(BuildContext context) {
    const tabs = [Center(child: TransformScreen()), Center(child: CaptureScreen()), Center(child: GestureTestScreen())];
    return const HomeTabsWidget(tabs);
  }
}


class HomeTabsWidget extends StatefulWidget {
  const HomeTabsWidget(this.tabs) : super();
  final List<Widget> tabs;
  @override
  _HomeTabsWidgetState createState() => _HomeTabsWidgetState();
}

class _HomeTabsWidgetState extends State<HomeTabsWidget> {
  static const List<String> titles = [ 'I', 'II', 'III', 'IV'];

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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Tab 1'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.textsms),
            title: Text('Tab 2'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove),
            title: Text('Tab 3'),
          ),
        ],
        currentIndex: index,
        unselectedItemColor: Colors.white12,
        selectedItemColor: Colors.white,

        unselectedFontSize: Theme.of(context).textTheme.button.fontSize,
        selectedFontSize: Theme.of(context).textTheme.button.fontSize,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
      ),
    );

    return screen;
  }
}
