import 'package:bai1/second_screen.dart';
import 'package:flutter/material.dart';

class First_Screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateFirstScreen();
  }
}
class StateFirstScreen extends State<First_Screen>{
  int ItemIndex=0;
  Widget buildUIBody(){
    if (ItemIndex==0){
      return Center(
        child: const Text("Trang Sản phẩm"),
      ) ;
    }
    else if (ItemIndex==1){
      return Center(
        child: const Text("Trang Giỏ hàng"),
      ) ;
    }
    else if (ItemIndex==2){
      return Center(
        child: const Text("Trang Cá nhân"),
      ) ;
    }
    return Center(
      child: const Text("Chưa có thông tin trang"),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        title: const Text("Cửa hàng"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.phone)
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.sms)
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.qr_code)
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
            children: [
              OutlinedButton(
                  onPressed: (){
                    Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context)
                            {
                              return Second_Screen("Châu Khải Vinh");
                            }
                        )
                    ).then((String? value){
                        if(value==null)
                        {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(value))
                        );
                      }
                    );
                  },
                  child: const Text("Chuyển sang Tab 2")
              ),
              OutlinedButton(
                child: const Text('Click me'),
                  onPressed: (){
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context){
                          return Container(
                            color: Colors.brown,
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            child: const Text("Xin cảm ơn các bạn đã mua hàng"),
                          );
                        }
                    );
                  },
              ),
              buildUIBody()
            ],
          ),
      ),

      floatingActionButton: IconButton(

          onPressed: (){},
          icon:Icon(Icons.phone),
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.brown,
        currentIndex: ItemIndex,
          onTap:(index){
            ItemIndex=index;
            setState(() {

            });
          } ,
          items:[
            BottomNavigationBarItem(
                icon:Icon(Icons.gif_box),
                label: 'Sản phẩm'

            ),
            BottomNavigationBarItem(

                icon:Icon(Icons.card_giftcard),
                label: 'Giỏ hàng'
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.person_search_outlined),
                label: 'Cá nhân'
            ),
          ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
                accountName: const Text("CHÂU KHẢI VINH"),
                accountEmail: const Text('chaukhaivinh1642@gmail.com'),
                decoration: BoxDecoration(
                  color: Colors.brown
                ),
                currentAccountPicture: CircleAvatar(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("Images/hihi.png"),
                    radius: 35,
                  ),
                ),
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: const Text("Cài đặt"),
            ),
            const Divider(height: 2,),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text("Đăng xuất"),
            ),
          ],
        ),
      ),
    );
  }

}