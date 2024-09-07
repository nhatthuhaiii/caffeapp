import 'package:caffeapp/src/cafe.dart';

class detail {
  late Caffe  a;
  late int sl ;
  late String size;
  detail(Caffe a, int b,String c ){
    this.sl=b;
    this.a=a;
    this.size=c;
  }
  void setcaffe(Caffe a){
    this.a= a;
  }
  void setsl(int b){
    this.sl = b;
  }
  Caffe getcaffe(){
    return this.a;
  }
  int getsl(){
    return this.sl;
  }
  bool equalcaffe(detail b){
    if(b.a.ma == this.a.ma)
     return true;
    return false;
  }
  void updateSL(int a){
    this.sl = this.sl+a;

  }
  Map<String, dynamic> toJson() {
    return {
      'caffe': a.toJson(), // Assuming Caffe class has a toJson method
      'sl': sl,
      'size': size,
    };
  }
  factory detail.fromJson(Map<String, dynamic> json) {
    return detail(
      Caffe.fromJson(json['caffe']), // Assuming Caffe class has fromJson method
      json['sl'] ?? 0, // Default to 0 if 'sl' is null
      json['size'] ?? '', // Default to empty string if 'size' is null
    );
  }

}