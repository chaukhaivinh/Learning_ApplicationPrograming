import 'dart:async';

class Cart {
  final Map<String, int> _bangGia;
  final Map<String, int> _items = {};

  // Đổi tên thành CartEvent
  final _stream = StreamController<CartEvent>.broadcast();
  
  Cart(this._bangGia);

  Stream<CartEvent> get stream => this._stream.stream;
  
  // Đổi Add -> add, Quantity -> quantity theo chuẩn Dart
  void add(String sku, int quantity) {
    if (quantity <= 0) { // Đổi thành <= 0
      throw Exception('Số lượng phải lớn hơn 0');
    }
    if (!this._bangGia.containsKey(sku)) {
      throw Exception('SKU "$sku" không tồn tại');
    }
    
    // Cộng dồn số lượng
    this._items[sku] = (this._items[sku] ?? 0) + quantity;
    
    // Rút gọn lại vì _items[sku] chắc chắn đã có giá trị
    var sumQuantity = this._items[sku]!;
    var total = _bangGia[sku]! * sumQuantity;
    
    this._stream.add(
      CartEvent(sku, sumQuantity, total)
    );
  }
  
  Future<void> dispose() => this._stream.close();
}

class CartEvent {
  String sku;
  int quantity, total;
  CartEvent(this.sku, this.quantity, this.total);
}

void main() {
  var cart = Cart({
    'Cà phê đá': 40000,
    'Matcha Latte': 75000,
    'Olong Nhài Machiato': 55000
  });
  
  var subTong = cart.stream
      .map((event) => event.total)
      .listen((data) {
        print('sub_tong: Tổng là: $data');
      });
      
  var subGt5 = cart.stream
      .where((event) => event.total >= 500000)
      .listen((data) {
        print("sub_gt_5: Đơn hàng VIP - sku = ${data.sku} total = ${data.total}");
      });
      
  // Đã sửa lại tên món cho khớp với _bangGia
  cart.add('Cà phê đá', 2);
  cart.add('Cà phê đá', 2);
  cart.add('Cà phê đá', 2);
  
  // Món này tổng 3 lần add là 6 ly * 40k = 240k (chưa đủ 500k để kích hoạt sub_gt_5)

  // Mua sỉ Matcha Latte để test event lớn hơn 500k
  cart.add('Matcha Latte', 10); 
}