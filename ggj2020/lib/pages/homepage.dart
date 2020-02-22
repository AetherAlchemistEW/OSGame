import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  GlobalKey key = GlobalKey();

  List items = [
    FlareMenuItem(name: 'Planet', color: Colors.purple),
    FlareMenuItem(name: 'Camera', color: Colors.greenAccent),
    FlareMenuItem(name: 'Heart', color: Colors.pink),
    FlareMenuItem(name: 'Person', color: Colors.yellow),
  ];

  FlareMenuItem active;

  List<Widget> _themeButtons(BuildContext context){
    List<Widget> buttons = new List<Widget>();

    for(var i = 0; i < widget.themeHandler.themeCount; i++){
      ThemeData data = widget.themeHandler.themes[i];
      buttons.add(Container(
        color: data.accentColor,
        child: RaisedButton(
            color: data.backgroundColor,
            elevation: data.buttonTheme.height,
            onPressed: () => widget.themeHandler.setTheme(i),
            child: Text("Theme $i", style: data.textTheme.display1,),
          ),
        )
      );
    }

    return buttons;
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
        backgroundColor: Theme.of(context).appBarTheme.color,
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
                'Select a theme:',
                style: Theme.of(context).textTheme.body1,
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _themeButtons(context),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

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
