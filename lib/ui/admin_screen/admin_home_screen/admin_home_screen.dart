import 'package:caffeapp/provider/getData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class admin_home_screen extends StatefulWidget {
  const admin_home_screen({super.key});

  @override
  State<admin_home_screen> createState() => _admin_home_screenState();
}

class _admin_home_screenState extends State<admin_home_screen> {
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //context.read<getData>().clearData(); // Clear store>

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 12,right: 12,top:10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Trang chủ",style: TextStyle(fontSize: 18),),
              IconButton(onPressed: (){
                context.read<getData>().clearData();
                Navigator.pop(context);

              }, icon: Icon(Icons.logout))
            ],)

          ],
        ),
      ),

    ));
  }
}
