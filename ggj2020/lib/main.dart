import 'package:flutter/material.dart';
import 'package:ggj2020/pages/Setup/login_page.dart';
//import 'package:ggj2020/pages/Setup/login_page.dart';
import 'package:provider/provider.dart';
import 'ThemeHandler.dart';
//import 'sidebar/sideBarLayout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeHandler _handler = ThemeHandler();

  @override
  Widget build(BuildContext context) {
    _handler.init();

    //Replace with provider when setting up new projects?
    return Provider<ThemeHandler>(
      create: (context) => _handler,
      child: StreamBuilder<ThemeData>(
        stream: _handler.themeStream,
          initialData: ThemeData.fallback(),
          builder: (context, snapshot){
            return new MaterialApp(
              title: 'Flutter Demo',
              theme: snapshot.data,
              home: LoginPage()//SideBarLayout(handler: handler)
            );
          }
      ),
    );
  }
}

