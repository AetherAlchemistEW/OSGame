import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'ThemeHandler.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'sidebar/sideBarLayout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

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
            home: SideBarLayout(handler: handler,)
            //home: new MyHomePage(title: 'Flutter Demo Home Page', themeHandler: handler),
          );
        }
    );
  }
}

