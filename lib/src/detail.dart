import 'package:caffeapp/src/cafe.dart';

class detail {
  late caffe  a;
  late int sl ;

  late String size;
  detail(caffe a, int b,String c ){
    this.sl=b;
    this.a=a;
    this.size=c;
  }
  void setcaffe(caffe a){
    this.a= a;
  }
  void setsl(int b){
    this.sl = b;
  }
  caffe getcaffe(){
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

}