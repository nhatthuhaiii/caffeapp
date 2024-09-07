import 'package:flutter/cupertino.dart';

import '../src/cafe.dart';
import '../src/detail.dart';

class cart extends ChangeNotifier {
  List<detail> lst = [];
  int tong = 0;
  bool isRenderOverlay = false;
  int gia = 0;

  addItems(detail a) {

    int size = a.size == "S" ? -5: a.size=="M"?0:5;
    gia =gia + (a.a.gia+size)*a.sl;
    tongadd(a);
    lst.add(a);
    xulilst();
    setFlag();
  }
  tinhtien(){
    gia =0;
    for(var item in lst) {
      String it = item.size;
      int size = it == "S" ? -5: it=="M" ? 0 : 5;
      gia = gia + item.sl * (item.a.gia+size);
    }
    return gia;

  }
  tongadd(detail i) {
    tong = tong + i.sl;
  }

  clear() {
    lst.clear();
    tong = 0;
    gia = 0;

    setFlag();
  }

  xulilst() {
    for (int i = 0; i < lst.length; i++) {
      for (int j = 0; j < lst.length; j++) {
        if (lst[i].a.ten.contains(lst[j].a.ten) && j != i&& lst[i].size.contains(lst[j].size)) {
          lst[i].sl = lst[i].sl + lst[j].sl;
          lst.remove(lst[j]);
        }
      }
    }
  }
  capnhat(detail x){
    for(var item in lst){
      if(item.a.ten==x.a.ten && item.size == x.size)
          item.sl = x.sl;
    }
    tinhtien();
    setFlag();
  }

  xoaIt(detail x) {
    lst.remove(x);
    gia=0;
    tong=0;
    for (detail x in lst) {
      gia = gia + x.sl * (x.a.gia);
      tong = tong + x.sl;
    }
    setFlag();
  }


  @override
  void setFlag({bool render = true}){
    isRenderOverlay = !isRenderOverlay;

    if(render){
      notifyListeners();
    }
  }
}
