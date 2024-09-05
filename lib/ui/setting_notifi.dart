import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class setting_notifi extends StatelessWidget {
  const setting_notifi({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Container(
                   margin: EdgeInsets.only(left: 12),
                   child: Text("Cài Đặt Thông Báo"
                   ,style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),

                   ),
                 ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin:EdgeInsets.only(right: 12) ,
                        child: Icon(Icons.close,color: Colors.green,size: 30,)),
                  )
                ],
              ),
            ),

        Container(
          height: 50,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
          border: Border.all(color: Colors.green)),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Row(
                  children: [
                    Text("Thông báo",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),


                  ],

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.topLeft,
                    child: Text("Khuyến khích luôn bật để nhận thông báo về tình trạng đơn hàng",
                       style: TextStyle(fontSize: 14),),
                  ),
                ],
              ),
        )


          ],
        ),
      ),
    );
  }
}
