import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
                "New Page"
            ),
            FloatingActionButton(
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      )
    );
  }
}
