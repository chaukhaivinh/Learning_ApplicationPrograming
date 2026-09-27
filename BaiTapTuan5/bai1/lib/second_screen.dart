import 'package:flutter/material.dart';

class Second_Screen extends StatelessWidget
{
  String name;
  TextEditingController textEdit=TextEditingController();
  Second_Screen(this.name,{super.key});

  @override
  Widget build(BuildContext context) {
    textEdit.text=name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('Giỏ hàng'),
      ),
      body: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: textEdit,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context,textEdit.text);
                  },
                  child: const Text("Submit")
              )
            ],
          )
      ),
    );
  }

}