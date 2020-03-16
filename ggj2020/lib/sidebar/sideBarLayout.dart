import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:ggj2020/ThemeHandler.dart';
import 'package:ggj2020/pages/homepage.dart';
import 'package:ggj2020/services/messageHandler.dart';
import 'package:provider/provider.dart';
import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
  SideBarLayout({this.user});
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      create: (context) => user.uid,
      child: Stack(
        children: <Widget>[
          MyHomePage(title: "Main Page"),
          SideBar(user: user),
          MessageHandler(),
        ],
      ),
    );
  }
}
