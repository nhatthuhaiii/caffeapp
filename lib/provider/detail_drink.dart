import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailDrinkProvider extends ChangeNotifier{
  int sl = 1;
  int total = 0;
  int  price= 0;
  bool fv = false;
  int SelectionSize = 2;
  int priceDefault = 0;
  int priceCalculate=0;
  List<String> lstfv = [];

  bool isRenderOverlay = false;
  setSelectionSize(int index){
    int valueSize = index ==1? -5 : index == 2 ? 0 : 5;
    priceCalculate = sl*(priceDefault + valueSize);


    SelectionSize = index;
    setFlag();
  }

  addDrink(){
    sl++;
    setSelectionSize(SelectionSize);
    total = price *sl;
    setFlag();
  }

  removeDrink(){
    if(sl>1){
      sl--;
      setSelectionSize(SelectionSize);
      total = price *sl;
      setFlag();
    }
  }
  setFv({required bool value}){
   fv= value;
    setFlag();
  }
  clickfv ( {required String username, required String nameProducts}) async{
    fv = !fv;
    setFlag();
    Future.delayed(Duration.zero, () async {
      try {
        if (fv) {
          await addProductToFavorites(username, nameProducts);
        } else {
          await removeProductFromFavorites(username, nameProducts);
        }
      } catch (e) {

        fv = !fv;
        setFlag();
      }
    });

  }

  clear(){
    sl = 1;
    total= 0;
    price=0;
    isRenderOverlay= false;
    fv = false;
    lstfv = [];
  }
  void setFlag({bool render = true}){
    isRenderOverlay = !isRenderOverlay;

    if(render){
      notifyListeners();
    }
  }

  Future<void> fetchProductsByAccount(String accountName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('account', isEqualTo: accountName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        lstfv = List<String>.from(userDoc['lstFv'] ?? []);
      } else {
        lstfv = []; // Nếu không tìm thấy user
      }

      notifyListeners(); // Cập nhật UI
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
    }
  }


  Future<void> addProductToFavorites(String account, String productName) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {

      QuerySnapshot userQuery = await _firestore
          .collection('users')
          .where('account', isEqualTo: account)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        String userId = userQuery.docs.first.id;


        await _firestore.collection('users').doc(userId).update({
          'lstFv': FieldValue.arrayUnion([productName]),
        });


      } else {

      }
    } catch (e) {

    }
  }
  Future<void> removeProductFromFavorites(String account, String productName) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {

      QuerySnapshot userQuery = await _firestore
          .collection('users')
          .where('account', isEqualTo: account)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        String userId = userQuery.docs.first.id;


        await _firestore.collection('users').doc(userId).update({
          'lstFv': FieldValue.arrayRemove([productName]),
        });


      } else {

      }
    } catch (e) {
      print(' $e');
    }
  }

}