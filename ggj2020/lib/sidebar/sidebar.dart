import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ggj2020/pages/newpage.dart';
import 'package:ggj2020/pages/map.dart';
import 'package:rxdart/rxdart.dart';
import 'menu_item.dart';

class SideBar extends StatefulWidget {

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {

  AnimationController _animationController;

  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;

  final _animationDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if(isAnimationCompleted){
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, snapshot) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: snapshot.data ? 0 : -screenWidth,
          right: snapshot.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.blueAccent[400],
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 100,),
                      FakeListTile(context, (snapshot.data)),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white,
                        indent: 16,
                        endIndent: 16,
                      ),
                      MenuItem(icon: Icons.home, title: "Home", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewPage()))),
                      MenuItem(icon: Icons.map, title: "Map", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Map()))),
                      MenuItem(icon: Icons.library_books, title: "Collection", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewPage()))),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0,-0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: Container(
                    width: 35,
                    height: 110,
                    color: Colors.blueAccent[400],
                    alignment: Alignment.centerLeft,
                    child: AnimatedIcon(
                      progress: _animationController.view,
                      icon: AnimatedIcons.menu_close,
                      color: Colors.blue[200],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

Widget FakeListTile(BuildContext context, bool open) {

  return Container(
    child: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Icon(
              Icons.perm_identity,
              color: Colors.white,
            ),
            radius: 40,
          ),
        ),

        Column(
          children: <Widget>[
            Text("Ralph", style: TextStyle(color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,),),
            Text("ralph@pexur.com", style: TextStyle(color: Colors.blue[200],
              fontSize: 20,
              fontWeight: FontWeight.w800,),),
          ],
        ),
      ],
    ),
  );
}