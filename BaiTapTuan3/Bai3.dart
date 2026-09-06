import 'dart:io';

class ApiException implements Exception{
  const ApiException(this.path);
  final String path;

  @override
  String toString() => 'ApiException khong tai duoc $path';
}
Future <String> EndPoint(String path, int ms, [bool fail=false]) async{
  await Future.delayed(Duration(milliseconds: ms));
  if (fail) throw ApiException(path);
  return path;
}

// Chạy song song 
void LoadHomeParallel() async{
   var result=await Future.wait([
    EndPoint('banner', 30),
    EndPoint('product', 20),
    EndPoint('categories', 40)
  ]);
  print("Tải song song: $result");
}

// Chạy chịu lỗi
void LoadHomeResilinet() async{
  final result =await Future.wait([
  EndPoint('banner', 30,true).catchError((Object e)=> 'Khong co Banner'),
  EndPoint('product', 20),
  EndPoint('categories', 40,true).catchError((Object e)=>'Khong co danh muc')
  ]);
  print("Tải chịu lỗi: $result");
}


void FastestCDN() async{
  final result =await Future.any([
    EndPoint('CD_HCM', 50),
    EndPoint('CDN_HN', 10),
    EndPoint('CDN_HA', 20),
  ]);
  print("CDN nhanh nhất là: $result");
}

void NotifyAll() async
{
  await Future.forEach(['Châu Khải Vinh','Vinh Khải Châu'], (email)=>print(email));
}
void main() async{
  FastestCDN();
  LoadHomeParallel();
  LoadHomeResilinet();
  NotifyAll();

}