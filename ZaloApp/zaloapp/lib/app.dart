import 'package:flutter/material.dart';
class ZaloApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Colors.blueAccent,
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Zalo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Tin nhắn",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        actions: [

          Align(
            alignment: Alignment.topCenter,
            child: IconButton(
              onPressed: () {},
              color: Colors.white,
              tooltip: 'Tìm kiếm',
              icon: Column(
                mainAxisSize: MainAxisSize.min, // Quan trọng: Giúp Column thu nhỏ lại vừa vặn nội dung
                children: [
                  Icon(Icons.search, size: 30),
                  Text(
                    "Tìm kiếm",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: IconButton(
              onPressed: () {},
              color: Colors.white,
              tooltip: 'Thêm',
              icon: Column(
                mainAxisSize: MainAxisSize.min, // Quan trọng: Giúp Column thu nhỏ lại vừa vặn nội dung
                children: [
                  Icon(Icons.add, size: 30),
                  Text(
                    "Thêm",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: IconButton(
              onPressed: () {},
              color: Colors.white,
              tooltip: 'Cài đặt',
              icon: Column(
                mainAxisSize: MainAxisSize.min, // Quan trọng: Giúp Column thu nhỏ lại vừa vặn nội dung
                children: [
                  Icon(Icons.settings, size: 30),
                  Text(
                    "Cài đặt",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.message),label: "Tin nhắn"),
          BottomNavigationBarItem(icon: Icon(Icons.contacts),label: "Danh bạ"),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt),label: "Nhật kí"),
        ]
      ),
    );
  }
}