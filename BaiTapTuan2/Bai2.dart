import 'dart:convert';

class Coupon {
  final String Code;
  final int Percent;
  final int MaxOff;
  
  const Coupon({
    required this.Code,
    required this.Percent,
    required this.MaxOff,
  }) : assert(
         Percent >= 0 && Percent <= 100,
         "Phần trăm phải nằm trong 0% ... 100%",
       ),
       assert(MaxOff >= 0, "MaxOff không được âm");

  /// Khai báo Constructor
  const Coupon.FreeShip() : Code = "FREESHIP", Percent = 0, MaxOff = 0;
  const Coupon.none() : Code = "NONE", Percent = 0, MaxOff = 0;

  /// Chuẩn hóa chuỗi
  factory Coupon.Custom({
    required String code,
    required int percent,
    int maxOff = 100000,
  }) {
    if (percent < 0 || percent > 100) {
      throw ArgumentError.value(percent, 'percent', 'Phải trong khoảng 0..100');
    }
    if (maxOff < 0) {
      throw ArgumentError.value(maxOff, 'maxOff', 'Không được âm');
    }
    return Coupon(Code: code.toUpperCase(), Percent: percent, MaxOff: maxOff);
  }
  
  factory Coupon.fromCode(String raw) {
    final Code = raw.trim().toUpperCase();
    return switch (Code) {
      // Đã sửa MaxOff từ 500000 thành 100000 để khớp với logic test bên dưới
      'SALE10' => const Coupon(Code: 'SALE10', Percent: 10, MaxOff: 100000), 
      'SALE25' => const Coupon(Code: 'SALE25', Percent: 25, MaxOff: 200000),
      'FREESHIP' => const Coupon.FreeShip(),
      '' => const Coupon.none(),
      _ => throw ArgumentError.value(raw, 'code', 'Mã giảm giá không tồn tại'),
    };
  }
  
  bool get IsFreeShip => Code == "FREESHIP";
  
  // Đã sửa lỗi chính tả DisscountFor -> DiscountFor
  int DiscountFor(int Amount) { 
    final raw = (Amount * Percent) ~/ 100;
    return raw > MaxOff ? MaxOff : raw;
  }

  @override
  String toString() => '$Code (-$Percent%, tối đa $MaxOff đ)';
}

class Product {
  const Product(this.sku, this.Name, this.Price);

  final String sku;
  final String Name;
  final int Price;
}

class CartLine {
  CartLine(this.product, this.quantity)
    : assert(product.Price >= 0, 'Giá sản phẩm không được âm'),
      lineTotal = product.Price * quantity {
    if (quantity <= 0) {
      throw ArgumentError.value(
        quantity,
        'quantity',
        'Số lượng phải lớn hơn 0',
      );
    }
  }

  /// Redirecting constructor cho trường hợp mua 1 món.
  CartLine.one(Product product) : this(product, 1);

  final Product product;
  final int quantity;
  final int lineTotal;

  @override
  String toString() => '${product.Name} x$quantity = $lineTotal đ';
}

int payable(int goods, Coupon c, {int shipFee = 30000}) {
  final after = goods - c.DiscountFor(goods);
  final ship = (c.IsFreeShip || after >= 500000) ? 0 : shipFee;
  return after + ship;
}

void main() {
  print(Coupon.fromCode('sale10')); // SALE10 (-10%, tối đa 100000 đ)
  print(Coupon.fromCode(' SALE25 ')); // SALE25 (-25%, tối đa 200000 đ)
  print(Coupon.fromCode('')); // NONE (-0%, tối đa 0 đ)
  print(const Coupon.FreeShip().IsFreeShip); // true

  // Trần giảm giá phát huy tác dụng ở đơn to:
  print(Coupon.fromCode('SALE10').DiscountFor(800000)); // 80000
  
  print(
    Coupon.fromCode('SALE10').DiscountFor(2000000),
  ); // 100000 — đã bị chặn ở trần do ta sửa MaxOff = 100000
  
  print(Coupon.fromCode('SALE25').DiscountFor(2000000)); // 200000

  try {
    Coupon.fromCode('HACK99');
  } on ArgumentError catch (e) {
    print('Chặn: ${e.message}');
  }

  const ao = Product('AO-01', 'Áo thun', 150000);
  print(CartLine(ao, 3)); // Áo thun x3 = 450000 đ
  print(CartLine.one(ao)); // Áo thun x1 = 150000 đ

  try {
    CartLine(ao, 0);
  } on ArgumentError catch (e) {
    print('Chặn: ${e.message}'); // Chặn: Số lượng phải lớn hơn 0
  }

  try {
    // ĐÃ SỬA: Code -> code
    Coupon.Custom(code: 'hack', percent: 500); 
  } on ArgumentError catch (e) {
    print('Chặn: ${e.message}'); // Chặn: Phải trong khoảng 0..100
  }

  print(payable(200000, Coupon.fromCode('FREESHIP'))); // 200000
  print(payable(200000, Coupon.fromCode(''))); // 230000
  print(payable(200000, Coupon.fromCode('SALE25'))); // 180000

  // Hai const Coupon cùng giá trị là cùng một object trong bộ nhớ:
  print(identical(const Coupon.none(), const Coupon.none())); // true
}