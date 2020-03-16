import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ggj2020/main.dart';
import 'package:ggj2020/pages/Setup/login_page.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
                "Sign Out"
            ),
            FloatingActionButton(
              onPressed: () => _signOut(context),
            )
          ],
        ),
      )
    );
  }

  Future<void> _signOut (BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      exit(0);
    } catch (e) {
      print(e.message);
    }
  }
}
