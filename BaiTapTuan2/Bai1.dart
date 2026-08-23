int PriceToTal({required int Price, required int Quality}){
  return Price*Quality;
}

int CheckoutTotal ({required List<int> LineTotal, int disscountPercent=0, int? ShipFee}){
  int TongTien=0;
  int ThanhTien=0;
  int TongGiam=0;
  for(var i in LineTotal){
    TongTien+=i;
    TongGiam=(TongTien*disscountPercent)~/100;
    ThanhTien=TongTien -TongGiam;
  }
  if (ThanhTien >=500000){
    return ThanhTien;
  }else{
    return ThanhTien + 30000;
  }
}
typedef PriceRule=int Function(int Amount);
int applyRules(int Amount, List<PriceRule> rules) {
  var result = Amount;
  for (final rule in rules) {
    result = rule(result);
  }
  return result;
}
void main(){
  var a=PriceToTal(Price: 30000, Quality: 2);
  var b=CheckoutTotal(LineTotal:[50000,30000,40000,70000,80000,100000,400000],disscountPercent:3);
  print("Bai 1");
  print(a);
  print("Bai 2:");
  print(b);
  
}