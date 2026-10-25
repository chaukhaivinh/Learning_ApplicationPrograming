import 'package:bai1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class YeuCau extends StatefulWidget{
  @override
  _YeuCau createState()=> _YeuCau();
}
class _YeuCau extends State<YeuCau>{
  Future<void> guiThongBao() async{
    var ketQuaQuyen=await phanAndroid?.requestNotificationsPermission();
    if(ketQuaQuyen !=null && ketQuaQuyen==true){
      await thongBao.show(
        id:1,
        title: 'Đơn hàng',
        body: 'Bạn có đơn hàng từ quán cà phê',
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(kenhDonHang.id, kenhDonHang.name)
        )
      );
    }
  }
  Future<void> guiThongBaoLenLich() async{
    var ketQuaQuyen=await phanAndroid?.requestNotificationsPermission();
    var ketQuaQuyenLenLich =await phanAndroid?.requestExactAlarmsPermission();
    if(ketQuaQuyen !=null && ketQuaQuyen==true && ketQuaQuyenLenLich != null && ketQuaQuyenLenLich==true){
      await thongBao.zonedSchedule(
          id:1,
          title: 'Đơn hàng',
          body: 'Bạn có đơn hàng từ quán cà phê',
          notificationDetails: NotificationDetails(
              android: AndroidNotificationDetails(kenhDonHang.id, kenhDonHang.name)
          ),
          scheduledDate: lanToiLuc(15,36),
          androidScheduleMode: AndroidScheduleMode.exact
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Colors.blue,
        title: Text(
          "Thông báo",
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      ),
      body:Center(
        child: Column(
          children: [
            OutlinedButton(
                style:OutlinedButton.styleFrom(
                  minimumSize: const Size(250, 40),
                  side: const BorderSide(color: Colors.blue,width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80)
                  )
                ) ,
                onPressed: guiThongBao,
                child:
                const Text(
                    "Gửi thông báo",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                )
            ),
            OutlinedButton(
                style:OutlinedButton.styleFrom(
                    minimumSize: const Size(250, 40),
                    side: const BorderSide(color: Colors.blue,width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80)
                    )
                ) ,
                onPressed: guiThongBaoLenLich,
                child:
                const Text(
                  "Gửi thông báo lên lịch",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

}