import 'package:flutter/material.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          child: Column(
          children: <Widget>[
            Text("New Page"),
            FloatingActionButton(
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      )
    );
  }
}
