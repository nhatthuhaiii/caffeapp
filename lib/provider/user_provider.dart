import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/user.dart';
import 'detail_drink.dart';

class user_provider extends ChangeNotifier{
  user? userinfo ;
 bool isRenderOverlay = false;

  loginUser(user b){
    userinfo=b;
    setFlag();
  }
  clear(){
    userinfo=null;
    setFlag();
  }

  void setFlag({bool render = true}){
    isRenderOverlay = !isRenderOverlay;

    if(render){
      notifyListeners();
    }
  }


  Future<void> deleteUserByUsername(String username) async {
    var usersRef = FirebaseFirestore.instance.collection('users');


    var querySnapshot = await usersRef.where('account', isEqualTo: username).get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete(); // Xóa từng document tìm được
      print("User ${doc.id} đã bị xóa.");
    }

    if (querySnapshot.docs.isEmpty) {
      print("Không tìm thấy user với username: $username");
    }
  }


  Future<user?> loginUserFireBase(String username, String password) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('account', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        user loggedInUser = user(
            name: userData['username'],
            userName: userData['account'],
            pass: userData['password'],
            phoneNumber: userData['phone'],
            fv:(userData['lstFv']as List<dynamic>?)?.map((item) => item.toString()).toList() ?? []);





        userinfo = loggedInUser;
        fetchProductsByAccount(userinfo!.userName);
        notifyListeners();

        return loggedInUser;
      } else {
        return null;
      }
    } catch (e) {
      print("Lỗi đăng nhập: $e");
      return null;
    }
  }
  void updateLocationUser(double  lat ,double long ){
     userinfo?.lat = lat;
     userinfo?.long = long;
     setFlag();


  }




  Future<bool> updateUserInfo({
    String? name,
    String? phoneNumber,
    String? password,
  }) async {
    try {

      if (userinfo == null) return false;


      Map<String, dynamic> updateData = {};


      if (name != null && name.isNotEmpty) {
        updateData['username'] = name;
        userinfo?.name = name;
      }

      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        updateData['phone'] = phoneNumber;
        userinfo?.phoneNumber = phoneNumber;
      }

      if (password != null && password.isNotEmpty) {
        updateData['password'] = password;
        userinfo?.pass = password;
      }


      if (updateData.isEmpty) return false;


      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('account', isEqualTo: userinfo?.userName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;


        await FirebaseFirestore.instance
            .collection('users')
            .doc(docId)
            .update(updateData);


        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      print("Lỗi cập nhật: $e");
      return false;
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
        userinfo!.fv  = List<String>.from(userDoc['lstFv'] ?? []);
      } else {
        userinfo!.fv= []; // Nếu không tìm thấy user
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