import 'package:flutter/material.dart';
class XacNhanDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.sms),
      title: const Text("Hôm nay ăn gì"),
      content: const Text("Ăn Busan"),
      actions: [
        TextButton(
          onPressed: ()=> Navigator.pop(context,true),
          child: const Text('Lụm')
        ),
        TextButton(
          style:TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
            onPressed: ()=> Navigator.pop(context,false),
            child: const Text('Không')
        ),
      ],
    );
  }

}