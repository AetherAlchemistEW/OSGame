import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:ggj2020/ThemeHandler.dart';
import 'package:meta/meta.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, @required this.themeHandler})
      : super(key: key);
  final ThemeHandler themeHandler;

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  GlobalKey key = GlobalKey();

  List items = [
    FlareMenuItem(name: 'Planet', color: Colors.purple),
    FlareMenuItem(name: 'Camera', color: Colors.greenAccent),
    FlareMenuItem(name: 'Heart', color: Colors.pink),
    FlareMenuItem(name: 'Person', color: Colors.yellow),
  ];

  FlareMenuItem active;

  void _incrementTheme() {
    setState(() {
      if (_counter < 2) {
        _counter++;
      } else {
        _counter = 0;
      }
      widget.themeHandler.index = _counter;
      DynamicTheme.of(context).setThemeData(widget.themeHandler.mainTheme());
    });
  }

  void _newPage(int index) {
    //Navigator.of(context).push(route)
  }

  @override
  void initState() {
    super.initState();

    active = items[0]; // <-- 1. Activate a menu item
  }

  @override
  Widget build(BuildContext context) {
    active = items[0];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: key,
        backgroundColor: Theme.of(context).appBarTheme.textTheme.title.color,
        buttonBackgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        color: Theme.of(context).accentColor,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeOut,
        items: <Widget>[
          //Icon(Icons.create),
          //Icon(Icons.ac_unit),
          //Icon(Icons.functions),
          _flare(items[0]),
          _flare(items[1]),
          _flare(items[2]),
          _flare(items[3]),
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
        onPressed: _incrementTheme,
        tooltip: 'Next theme',
        child: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color,),
      ),
    );

  }

  /*Widget _navBarElement(BuildContext context, int index){
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      color: Colors.black,
      child: Stack(
        //  <-- 2. Define a stack
        children: [
          AnimatedContainer(
            //  <-- 3. Animated top bar
            duration: Duration(milliseconds: 200),
            alignment: Alignment(active.x, -1),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              height: 8,
              width: w * 0.2,
              color: active.color,
            ),
          ),
          Container(
            // <-- 4. Main menu row
              child: _flare(items[index]),
                    // _flare(items[1]),
                    //_flare(items[2]),
                    //_flare(items[3]),
          )
        ],
      ),
    );
  }*/

  Widget _flare(FlareMenuItem item) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: FlareActor(
            'assets/${item.name}.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: 'go',
          ),
        ),
      ),
      /*onTap: () {
        setState(() {
          active = item;
        });
      },*/
    );
  }
}

class FlareMenuItem {
  final String name;
  final Color color;
  FlareMenuItem({this.name, this.color});
}
