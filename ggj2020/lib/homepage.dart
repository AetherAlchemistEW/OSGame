import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:ggj2020/ThemeHandler.dart';
import 'package:meta/meta.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, @required this.themeHandler}) : super(key: key);
  final ThemeHandler themeHandler;

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _page;
  GlobalKey key = GlobalKey();

  void _incrementCounter() {
    setState(() {
      if(_counter < 2) {
        _counter++;
      } else {
        _counter = 0;
      }
      widget.themeHandler.index = _counter;
      DynamicTheme.of(context).setThemeData(widget.themeHandler.mainTheme());
    });
  }

  void _newPage(int index){
    Navigator.of(context).push(route)
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: key,
        backgroundColor: Theme.of(context).appBarTheme.textTheme.title.color,
        buttonBackgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        color: Theme.of(context).accentColor,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeOut,
        items: <Widget>[
          Icon(Icons.create),
          Icon(Icons.ac_unit),
          Icon(Icons.functions),
        ],
        onTap: (index){
          setState(() {
            _newPage(index);
          });
        },
      ),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
                style: Theme.of(context).textTheme.body1,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: Theme.of(context).floatingActionButtonTheme.elevation,
        onPressed: _incrementCounter,
        tooltip: 'Next theme',
        child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
      ),
    );
  }
}
