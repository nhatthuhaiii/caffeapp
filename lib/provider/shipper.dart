import 'package:flutter/material.dart';

import '../src/dathang.dart';

class shipper extends ChangeNotifier{
  List<dathang> lstorder = [];
   bool isRenderOverlay = false;

   addList(dathang a ){


    lstorder.add(a);


    setFlag();

  }
  clear(){
    lstorder.clear();
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
