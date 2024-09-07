import 'package:caffeapp/ui/main_screen/Screen_orderProduct/orderdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../src/dathang.dart';

class shipper extends ChangeNotifier{
  List<dathang> lstorder = [];
   bool isRenderOverlay = false;

   adddathang(dathang a)
   {


    lstorder.add(a);


    setFlag();

  }



  Future<bool> saveOrderToFirebase(dathang donHangMoi) async {
    try {
      // Tham chiếu đến collection
      CollectionReference orders = FirebaseFirestore.instance.collection('orderdetail');

      // Thêm đơn hàng, để Firebase tự tạo ID
      DocumentReference docRef = await orders.add({
        'lst': donHangMoi.lst.map((item) => item.toJson()).toList(),
        'ad_dat': donHangMoi.ad_dat!.toJson(),
        'ad_nhan': donHangMoi.ad_nhan,
        'nguoinhan': donHangMoi.nguoinhan!.toJson(),
        'sdt': donHangMoi.sdt,
        'sl': donHangMoi.sl,
        'gia': donHangMoi.gia,
        'giamgia': donHangMoi.giamgia,
        'phigiaohang': donHangMoi.phigiaohang,
        'timestamp': FieldValue.serverTimestamp(),
        'lat': donHangMoi.lat,
        'long': donHangMoi.long,
        'thanhtoan': donHangMoi.thanhtoan,
        'trangthai':donHangMoi.trangthai
      });


      String generatedId = docRef.id;


      await docRef.update({'id': generatedId});

      return true;
    } catch (e) {
      print('Lỗi khi lưu đơn hàng: $e');
      return false;
    }
  }
  Future<List<dathang>> getOrdersByUsername(String username) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orderdetail')
          .where('nguoinhan.userName', isEqualTo: username)
          .get();

      List<dathang> orderList = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return dathang.fromJson(data);
      }).toList();

      print('Số lượng đơn hàng tìm được: ${orderList.length}');
      return orderList;
    } catch (e) {
      print("Lỗi khi lấy đơn hàng: $e");
      return [];
    }
  }



  clear(){
    lstorder.clear();
    setFlag();
  }
  void setFlag({bool render = true}){
    isRenderOverlay = !isRenderOverlay;

    if(render){
      notifyListeners();
    }
  }
}
