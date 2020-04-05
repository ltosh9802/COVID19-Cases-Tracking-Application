import 'package:flutter/material.dart';
import 'selectcountryscreen.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
          primaryColor: Color(0xff00204a),
          appBarTheme: AppBarTheme(color: Color(0xff00204a)),
          accentColor: Color(0xff00204a),
          backgroundColor: Color(0xffd9faff),
      ),

      // home: Scaffold(
      //   appBar: AppBar(title: Text("CoronaTracker"), ),
      //   body: Text('I wish I was dead'),
      // ),
      initialRoute: '/',
      routes:{
        '/' : (context) => SelectCountry(),
      }

    );
  }
}