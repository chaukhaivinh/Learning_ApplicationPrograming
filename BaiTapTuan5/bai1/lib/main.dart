import 'package:bai1/first_screen.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(testApp2());
}
class testApp2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: First_Screen()
    );
  }

}