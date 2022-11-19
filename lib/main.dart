import "package:flutter/material.dart";
import "package:app_weather/pages/home.dart";

void main() => runApp(MyApp());

class MyApp  extends StatelessWidget{
  Widget build (BuildContext context) {
    return MaterialApp(
      title: 'Weather App Design',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: Home(),

    );
  }
}
