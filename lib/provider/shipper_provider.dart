import 'package:caffeapp/src/shipper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../src/dathang.dart';



class shipper_provider extends ChangeNotifier{
  shippeUser? info ;
  bool isRenderOverlay = false;
  dathang? item;
  shipperLogin(shippeUser a ){
    info=a;
    setFlag();
  }
  clearShipper(){
    info = null;
    notifyListeners();
  }
  setStatus (bool a){
    info!.status = a;
    notifyListeners();
  }
  Future<dathang?>? getOrderById (String id ) async{
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.
      instance.collection('orderdetail').where('id',isEqualTo: id).get();
      if(querySnapshot.docs.isNotEmpty){
        var x = querySnapshot.docs.first.data() as Map<String, dynamic>;
        dathang temp = dathang.fromJson(x);
        item = temp;

        notifyListeners();
        return item;

      }

    }
    catch (e){
      print("loi" + e.toString());

    }
    return null;

  }


  Future<shippeUser?> shipperLoginFireBase(String username, String password) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('shipper')
          .where('userName', isEqualTo: username)
          .where('pass', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var shipperData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        shippeUser loggedInShipper = shippeUser(
          id: querySnapshot.docs.first.id,
          name: shipperData['name'],
          phone: shipperData['phone'],
          status: shipperData['status'],
          lat: (shipperData['lat'] as num?)?.toDouble() ?? 0.0,
          long: (shipperData['long'] as num?)?.toDouble() ?? 0.0,
          userName: shipperData['userName'],
          pass: shipperData['pass'],
        );


        info = loggedInShipper;

        notifyListeners();

        return loggedInShipper;
      } else {
        print("Shipper not found");
        return null;
      }
    } catch (e) {
      print("Lỗi đăng nhập shipper: $e");
      return null;
    }
  }






  void setFlag({bool render = true}){
    isRenderOverlay = !isRenderOverlay;

    if(render){
      notifyListeners();
    }
  }


}