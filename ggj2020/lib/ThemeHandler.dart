import 'package:flutter/material.dart';

class ThemeHandler{
  int index = 0;

  ThemeData mainTheme(){
    final List<ThemeData> themes = List<ThemeData>();
    themes.add(destroyedTheme());
    themes.add(partialRepairTheme());
    themes.add(repairedTheme());

    return themes[index];
  }

  ThemeData destroyedTheme(){
    return ThemeData(
      colorScheme: ColorScheme.dark(),
      backgroundColor: Colors.black,
      accentColor: Colors.grey,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.black26,
        backgroundColor: Colors.white,
        elevation: 2.0,
      ),
      iconTheme: IconThemeData(
        color: Colors.red,
      ),
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.white70,
          fontStyle: FontStyle.italic,
        ),
        display1: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.1,
        textTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.lineThrough,
            decorationStyle: TextDecorationStyle.wavy,
            decorationThickness: 2,
            color: Colors.amber,
            letterSpacing: 2,
            height: 2,
          )
        )
      ),
      cardTheme: CardTheme(),
      dialogTheme: DialogTheme(),
      disabledColor: Colors.redAccent[100],
      dialogBackgroundColor: Colors.white30,
    );
  }

  ThemeData partialRepairTheme(){
    return ThemeData(
      colorScheme: ColorScheme.dark(),
      backgroundColor: Colors.deepPurple,
      accentColor: Colors.deepPurpleAccent,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.pinkAccent,
        backgroundColor: Colors.pink,
        elevation: 5.0,
      ),
      iconTheme: IconThemeData(
        color: Colors.green,
      ),
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.cyan,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        display1: TextStyle(
          color: Colors.teal,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      appBarTheme: AppBarTheme(
          elevation: 2,
          textTheme: TextTheme(
              title: TextStyle(
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.overline,
                decorationStyle: TextDecorationStyle.double,
                decorationThickness: 2,
                color: Colors.pinkAccent,
                letterSpacing: 8,
                height: 2,
                fontSize: 18
              )
          )
      ),
      cardTheme: CardTheme(),
      dialogTheme: DialogTheme(),
      disabledColor: Colors.blueAccent[100],
      dialogBackgroundColor: Colors.purple,
    );
  }

  ThemeData repairedTheme(){
    return ThemeData(
      colorScheme: ColorScheme.dark(),
      backgroundColor: Colors.white,
      accentColor: Colors.blueAccent[100],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.blueAccent,
        backgroundColor: Colors.lightBlueAccent[100],
        elevation: 2.0,
      ),
      iconTheme: IconThemeData(
        color: Colors.indigo,
      ),
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
        display1: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
      ),
      appBarTheme: AppBarTheme(
          elevation: 0.5,
          color: Colors.indigo,
          textTheme: TextTheme(
              title: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24
              )
          )
      ),
      cardTheme: CardTheme(),
      dialogTheme: DialogTheme(),
      disabledColor: Colors.blueGrey[100],
      dialogBackgroundColor: Colors.white,
    );
  }
}