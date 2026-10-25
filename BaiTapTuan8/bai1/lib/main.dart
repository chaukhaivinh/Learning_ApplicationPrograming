import 'package:bai1/YeuCau_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
final thongBao=FlutterLocalNotificationsPlugin();

AndroidFlutterLocalNotificationsPlugin? get phanAndroid=>thongBao.
resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
const kenhDonHang=AndroidNotificationChannel(
  'donHang',
  'Đơn hàng',
  description: "Xác nhận, đang giao, đã giao",
  importance: Importance.high,
);


// THÔNG BÁO THƯỜNG


Future<void> khoiTaoThongBao({
  void Function(NotificationResponse phanHoi)? khiNhan,
})async{
  await thongBao.initialize(
    settings: const InitializationSettings(
      // Tên icon nhỏ hiện trên thanh trạng thái. `ic_launcher` là icon ứng
      // dụng mà `flutter create` sinh sẵn.
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse: khiNhan,
  );
  await phanAndroid?.createNotificationChannel(kenhDonHang);
}


// THÔNG BÁO LÊN LỊCH

Future<void> khoiTaoMuiGio() async {
  // Nạp bảng múi giờ của cả thế giới vào bộ nhớ.
  tzdata.initializeTimeZones();
  // Hỏi máy xem đang đặt múi giờ nào — ví dụ "Asia/Ho_Chi_Minh".
  final vung = await FlutterTimezone.getLocalTimezone();
  try {
    // Từ đây, `tz.local` là giờ của máy người dùng.
    tz.setLocalLocation(tz.getLocation(vung.identifier));
  } on tz.LocationNotFoundException {
    // Phòng khi máy trả về một tên mà bảng không có: dùng giờ Việt Nam, thay
    // vì để lỗi làm ứng dụng dừng ngay lúc mở.
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
  }
}
tz.TZDateTime lanToiLuc(int gio, int phut, {tz.TZDateTime? bayGio}) {
  bayGio ??= tz.TZDateTime.now(tz.local);
  final homNay = tz.TZDateTime(
    bayGio.location,
    bayGio.year,
    bayGio.month,
    bayGio.day,
    gio,
    phut,
  );
  if (homNay.isAfter(bayGio)) return homNay;
  return tz.TZDateTime(
    bayGio.location,
    bayGio.year,
    bayGio.month,
    bayGio.day + 1,
    gio,
    phut,
  );
}
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  khoiTaoThongBao();
  khoiTaoMuiGio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YeuCau(),
    );
  }
}