import 'package:flutter/material.dart';

class DetailDrinkProvider extends ChangeNotifier{
  int sl = 1;
  int total = 0;
  int  price= 0;
  bool fv = false;

  bool isRenderOverlay = false;

  addDrink(){
    sl++;
    total = price *sl;
    setFlag();
  }

  removeDrink(){
    if(sl>1){
      sl--;
      total = price *sl;
      setFlag();
    }
  }
  clickfv(){
    fv =!fv;




    setFlag();


  }

  clear(){
    sl = 1;
    total= 0;
    price=0;
    isRenderOverlay= false;
    fv = false;
  }
  void setFlag({bool render = true}){
    isRenderOverlay = !isRenderOverlay;

    if(render){
      notifyListeners();
    }
  }
}