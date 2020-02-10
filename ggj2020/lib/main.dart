import 'package:flutter/material.dart';
import 'homepage.dart';
import 'ThemeHandler.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeHandler handler = ThemeHandler();

  @override
  Widget build(BuildContext context) {

    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => handler.mainTheme(),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            home: new MyHomePage(title: 'Flutter Demo Home Page', themeHandler: handler),
          );
        }
    );
  }
}

