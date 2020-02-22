import 'package:flutter/material.dart';
import 'ThemeHandler.dart';
import 'sidebar/sideBarLayout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeHandler handler = ThemeHandler();

  @override
  Widget build(BuildContext context) {
    handler.init();

    return StreamBuilder<ThemeData>(
      stream: handler.themeStream,
        initialData: ThemeData.fallback(),
        builder: (context, snapshot){
          return new MaterialApp(
            title: 'Flutter Demo',
            theme: snapshot.data,
            home: SideBarLayout(handler: handler)
          );
        }
    );
  }
}

