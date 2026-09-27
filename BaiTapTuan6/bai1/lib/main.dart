import 'package:bai1/Dialog_Screen.dart';
import 'package:bai1/Grid_View_Screen.dart';
import 'package:bai1/List_View_Screen.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(App());
}
class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DialogScreen()
    );
  }

}