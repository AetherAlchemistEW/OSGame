import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ThemeHandler.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {

  List<Widget> _themeButtons(BuildContext context, ThemeHandler themeHandler){
    List<Widget> buttons = new List<Widget>();

    for(var i = 0; i < themeHandler.themeCount; i++){
      ThemeData data = themeHandler.themes[i];
      buttons.add(Container(
        color: data.accentColor,
        child: RaisedButton(
          color: data.backgroundColor,
          elevation: data.buttonTheme.height,
          onPressed: () => themeHandler.setTheme(i),
          child: Text("Theme $i", style: data.textTheme.display1,),
        ),
      )
      );
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    ThemeHandler themeHandler = Provider.of<ThemeHandler>(context);

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select a theme:',
              style: Theme.of(context).textTheme.body1,
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _themeButtons(context, themeHandler),
              ),
            )
          ],
        ),
      ),
    );
  }
}
