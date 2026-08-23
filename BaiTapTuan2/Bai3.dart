import 'dart:collection';

/// Đáp án Phần 3 — Inventory đóng gói toàn bộ quy tắc tồn kho.
class Inventory {
  Inventory({required int lowStockThreshold}) {
    // Đi qua setter để dùng lại phần kiểm tra, không lặp code.
    this.lowStockThreshold = lowStockThreshold;
  }

  /// Dữ liệu thật: private, ngoài file này không ai chạm được.
  final Map<String, int> _stock = {};
  int _lowStockThreshold = 5;

  /// Chỉ được gán một lần, và gán muộn — sau khi hệ thống chọn được kho.
  late final String warehouseCode;

  /// `late final` TỰ NÓ đã chặn lần gán thứ hai (ném LateInitializationError).
  /// Cờ này chỉ để đổi thông báo thành StateError có ngữ cảnh nghiệp vụ — nêu
  /// rõ đang gán kho nào. Đừng học thói quen "cứ late final là kèm một cờ bool".
  bool _warehouseAssigned = false;

  /// Getter chỉ cho đọc. Trả thẳng `_stock` ra thì người gọi sửa được map bên
  /// trong, và mọi quy tắc ở trên thành vô nghĩa.
  ///
  /// Ở đây dùng `UnmodifiableMapView`, không dùng `Map.unmodifiable`. Khác biệt:
  ///
  /// `Map.unmodifiable` chép ra một map mới rồi khoá lại. Ai giữ kết quả đó sẽ
  /// đọc mãi số liệu của lúc gọi, dù kho đã nhập thêm hàng. Và mỗi lần gọi
  /// getter là một lần chép lại toàn bộ.
  ///
  /// `UnmodifiableMapView` chỉ bọc thêm một lớp chặn ghi lên chính `_stock`.
  /// Không chép gì, nhập thêm hàng là đọc thấy ngay, mà ghi vào thì vẫn bị từ chối.
  Map<String, int> get stock => UnmodifiableMapView(_stock);

  int get totalUnits => _stock.values.fold(0, (a, b) => a + b);

  int get lowStockThreshold => _lowStockThreshold;

  set lowStockThreshold(int value) {
    if (value < 0) {
      throw ArgumentError.value(value, 'lowStockThreshold', 'Không được âm');
    }
    _lowStockThreshold = value;
  }

  List<String> get lowStockSkus => _stock.entries
      .where((e) => e.value <= _lowStockThreshold)
      .map((e) => e.key)
      .toList();

  void assignWarehouse(String code) {
    if (_warehouseAssigned) {
      throw StateError('Đã gán kho $warehouseCode, không đổi được');
    }
    warehouseCode = code;
    _warehouseAssigned = true;
  }

  void receive(String sku, int qty) {
    if (qty <= 0) throw ArgumentError.value(qty, 'qty', 'Phải lớn hơn 0');
    _stock[sku] = (_stock[sku] ?? 0) + qty;
  }

  /// Trả về true nếu xuất được. Không ném lỗi vì "hết hàng" là chuyện BÌNH
  /// THƯỜNG trong nghiệp vụ, không phải lỗi lập trình.
  bool release(String sku, int qty) {
    final current = _stock[sku] ?? 0;
    if (qty <= 0 || qty > current) return false;
    _stock[sku] = current - qty;
    return true;
  }

  int quantityOf(String sku) => _stock[sku] ?? 0;
}

void main() {
  final inv = Inventory(lowStockThreshold: 3);
  inv.assignWarehouse('KHO-HCM-01');
  print(inv.warehouseCode); // KHO-HCM-01

  inv.receive('AO-01', 10);
  inv.receive('QU-01', 2);
  inv.receive('AO-01', 5);

  print(inv.quantityOf('AO-01')); // 15
  print(inv.totalUnits);          // 17
  print(inv.lowStockSkus);        // [QU-01]

  print(inv.release('AO-01', 4));   // true
  print(inv.release('AO-01', 100)); // false — không đủ hàng
  print(inv.quantityOf('AO-01'));   // 11

  inv.lowStockThreshold = 12;
  print(inv.lowStockSkus); // [AO-01, QU-01]

  try {
    inv.lowStockThreshold = -1;
  } on ArgumentError catch (e) {
    print('Chặn: ${e.message}');
  }

  try {
    inv.assignWarehouse('KHO-HN-01');
  } on StateError catch (e) {
    print('Chặn: ${e.message}');
  }

  // Getter trả về lớp bọc, không phải bản chép — nên nhập thêm hàng là thấy ngay.
  final view = inv.stock;
  inv.receive('AO-01', 100);
  print(view['AO-01']); // 111 — vẫn biến view cũ, nhưng số đã đổi

  // Nhưng sửa vào nó thì bị chặn -> quy tắc trong class không bị lách.
  try {
    inv.stock['AO-01'] = 9999;
  } on UnsupportedError catch (_) {
    print('Chặn: không sửa được stock từ bên ngoài');
  }
}