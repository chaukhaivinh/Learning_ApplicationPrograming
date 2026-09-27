import 'package:bai1/Dialog.dart';
import 'package:flutter/material.dart';
class GridViewScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child:Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1,

                ),
                itemBuilder: (BuildContext context,int i){
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network('https://res.cloudinary.com/dtz0urit6/image/upload/q_auto:best,f_jpg/cloudinary-tools-uploads/lwi9taoonhotakhmhgzc'),
                  );
                },
                itemCount: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

}