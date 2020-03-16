//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
//import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
//import 'package:ggj2020/ThemeHandler.dart';
import 'package:ggj2020/pages/ThemePage.dart';
import 'package:ggj2020/pages/collection.dart';
import 'package:ggj2020/pages/filesPage.dart';
import 'package:ggj2020/pages/newpage.dart';
//import 'package:meta/meta.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey key = GlobalKey();
  int _barIndex = 0;

  List items = [
    FlareMenuItem(name: 'Planet', color: Colors.purple, controller: new FlareControls()),
    FlareMenuItem(name: 'Camera', color: Colors.greenAccent, controller: new FlareControls()),
    FlareMenuItem(name: 'Heart', color: Colors.pink, controller: new FlareControls()),
    FlareMenuItem(name: 'Person', color: Colors.yellow, controller: new FlareControls()),
  ];

  List<FlareControls> controllers;

  //FlareMenuItem active;

  /*Navigator _newPage(int index) {

  }*/

  @override
  void initState() {
    super.initState();
    controllers = new List<FlareControls>();

    for(int i = 0; i < items.length; i++){
      FlareMenuItem c = items[i];
      controllers.add(c.controller);
    }
    //active = items[0]; // <-- 1. Activate a menu item
  }

  @override
  Widget build(BuildContext context) {
    //active = items[0];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        key: key,
        //Theme.of(context).appBarTheme.color,
        //showSelectedLabels: true,
        //showUnselectedLabels: false,
        onTap: (int x) {setState(() {
          _barIndex = x;
          //set route here
          controllers[x].play('go');
        });},
        currentIndex: _barIndex,
        iconSize: 50,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _flare(items[0]),
            title: Text(""),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon:  _flare(items[1]),
            title: Text(""),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon:  _flare(items[2]),
            title: Text(""),
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),//_flare(items[3]),
            title: Text("Profile"),
            backgroundColor: Colors.green,
          ),
        ],
      ),
      /*CurvedNavigationBar(
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
      ),*/
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).accentColor,
      ),

      body: Navigator(
        onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context){
            switch(_barIndex){
              case 0:
                return ThemePage();
              case 1:
                return FilesPage();
              case 2:
                return CollectionPage();
              case 3:
                return NewPage();
            }
            return null;
          }
      );
    },
    )
      /*Container(
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
      ),*/
    );
  }

  Widget _flare(FlareMenuItem item) {
    return GestureDetector(
        child: AspectRatio(
          aspectRatio: 2,
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: FlareActor(
              'assets/${item.name}.flr',
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              animation: 'go',
              controller: item.controller,
            ),
          ),
        ),
        /*onTap: () {
          setState(() {
            //active = item;
          });
        },*/
      );
  }
}

class FlareMenuItem {
  final String name;
  final Color color;
  final FlareControls controller;
  FlareMenuItem({this.name, this.color, this.controller});
}
