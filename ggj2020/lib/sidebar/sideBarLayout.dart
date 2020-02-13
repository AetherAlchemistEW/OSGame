import 'package:flutter/material.dart';
import 'package:ggj2020/ThemeHandler.dart';
import 'package:ggj2020/pages/homepage.dart';
import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
  SideBarLayout({this.handler});
  final ThemeHandler handler;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyHomePage(title: "Main Page",themeHandler: handler),
        SideBar(),
      ],
    );
  }
}
