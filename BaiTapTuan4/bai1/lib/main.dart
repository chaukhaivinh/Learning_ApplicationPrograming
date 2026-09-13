import 'package:flutter/material.dart';
void main(){
  runApp(testApp());
}
class testApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                DemoStateFullWidget(),
                Padding(padding: const EdgeInsets.all(20),child: Image.asset('Images/sontung.jpg'),),
                Stack(
                  children: [
                    Container(width: 220, height: 140, color: const Color(0xFF80CBC4)),
                    Container(width: 160, height: 100, color: const Color(0xFFFFCC80)),
                    Container(width: 90, height: 60, color: const Color(0xFFCE93D8)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class DemoStateFullWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   
    return ButtonWidge();
  }
}
class ButtonWidge extends State<DemoStateFullWidget>{
  int Count=0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Gio hang= ${Count}"),
        ElevatedButton(onPressed: ()=> setState(()=>Count++)
        , child: const Text("Them"))
      ],
    );
  }
}