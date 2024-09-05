import 'detail.dart';

class dathang{
   final List<detail> lst;
   String? nguoinhan;
  String? sdt;

  String? ad_nhan;
   String? ad_dat;
   DateTime? times;
  dathang(this.lst,  String b ,String c,String d,String e, ){
      this.lst;
      this.ad_dat=b;
      this.nguoinhan=d;
      this.sdt=e;
      this.ad_nhan=c;
      this.times = DateTime.now();

  }
}