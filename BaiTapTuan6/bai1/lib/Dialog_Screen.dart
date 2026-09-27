import 'package:bai1/Dialog.dart';
import 'package:flutter/material.dart';
class DialogScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OutlinedButton(
                onPressed: () async{
                  var result=await showDialog<bool>(
                      context: context,
                      builder: (context) =>XacNhanDialog()
                  );
                  if (result ==null){
                    return;
                  }
                  print("Câu trả lời là ${result}");
                },
                child:const Text('Ăn gì nào ???')
            ),
          ],
        )
      ),
    );
  }

}