import 'package:flutter/material.dart';
class ListViewScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context,i){
                  return ListTile(
                    title: Text('Vinh ${i}'),
                    subtitle: Text('Chau ${i}'),
                    leading: CircleAvatar(
                      child: Text('${i}'),
                    ),
                    trailing: Text('Trang ${i}'),
                  );
                },
                itemCount: 1000,
                padding: EdgeInsets.all(20),
              )
            ),
          ],
        )
      ),
    );
  }
  
}