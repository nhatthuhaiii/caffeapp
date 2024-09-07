import 'package:caffeapp/provider/user_provider.dart';
import 'package:caffeapp/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../provider/user_provider.dart';
import '../../../src/user.dart';

class registerTabs extends StatefulWidget {
   registerTabs({super.key});

  @override
  State<registerTabs> createState() => _registerTabsState();
}

class _registerTabsState extends State<registerTabs> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String username;
  late String accuont;
  late String pass;
  late String repass;
  late String phone;
  void registerUser() async {
    if (pass != repass) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mật khẩu nhập lại không khớp!")),
      );
      return;
    }

    try {
      await _firestore.collection('users').add({
        'username': username,
        'account': accuont,
        'phone': phone,
        'password': pass,
        'lat': 0.0,
        'long': 0.0,
        'created_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng ký thành công!")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $e")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
        
          children: [
            Container(
              height: 30,
              color: Colors.orange,
              padding: EdgeInsets.only(left: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
        
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
        
                    ),
                  ),
        
        
                  Text("Đăng kí",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
        
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12,right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        
                  SizedBox(height: 10,),
                  Text("Tên Khách Hàng"),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withOpacity(0.5))
                    ),
                    child: TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
        
                        onChanged: (value) {
                          this.username= value;
                        },
                        decoration: InputDecoration(
                          hintText: "Họ tên",
                          icon: Icon(Icons.person,color: Colors.orange,),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8)),
                        )),
                  ),
                  SizedBox(height: 10,),
                  Text("Số điện thoại"),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withOpacity(0.5))
                    ),
                    child: TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
        
                        onChanged: (value) {
                          this.phone = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Số điện thoại",
                          icon: Icon(Icons.phone,color: Colors.orange,),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8)),
                        )),
                  ),
                  SizedBox(height: 10,),
                  Text("Tên Tài Khoản"),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withOpacity(0.5))
                    ),
                    child: TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
        
                        onChanged: (value) {
                          this.accuont = value;
                        },
                        decoration: InputDecoration(
                          hintText: " Tên Tài khoản",
                          icon: Icon(Icons.person,color: Colors.orange,),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8)),
                        )),
                  ),
        
                  SizedBox(height: 10,),
                  Text("Mật khẩu"),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withOpacity(0.5))
                    ),
                    child: TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        obscuringCharacter: "*",
                        obscureText: true,
                        onChanged: (value) {
                          this.pass = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Nhập mật khẩu",
                          icon: Icon(Icons.key_outlined,color: Colors.orange,),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8)),
                        )
                    ),
        
        
                  ),
                  SizedBox(height: 10,),
                  Text("Nhập lại mật khẩu"),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withOpacity(0.5))
                    ),
                    child: TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        obscuringCharacter: "*",
                        obscureText: true,
                        onChanged: (value) {
                          this.repass = value;
                        },
                        decoration: InputDecoration(
                          hintText: " Nhập lại mật khẩu",
                          icon: Icon(Icons.key,color: Colors.orange,),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8)),
                        )
                    ),
        
        
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap:(){
                      registerUser();
                      Navigator.pop(context);
        
        
        
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.orange
                        ,
                        borderRadius:BorderRadius.circular(10),
        
                      ),
        
                      child: Center(child: Text("Đăng kí",style: TextStyle(color: Colors.white),)),
        
                    ),
                  )
        
                ],
        
              ),
            ),
          ],
        ),
      ),

    ));
  }
}
