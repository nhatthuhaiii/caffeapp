import 'package:caffeapp/provider/shipper.dart';
import 'package:caffeapp/ui/thongtindonhang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/dathang.dart';

class notifitabs extends StatefulWidget {
     notifitabs({super.key});

  @override
  State<notifitabs> createState() => _notifitabsState();
}

class _notifitabsState extends State<notifitabs> {
  @override
  List<dathang> lst =[];

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
   lst = context.read<shipper>().lstorder;


  }
  Widget build(BuildContext context) {

    return SafeArea(

        child: Scaffold
          (
          body:SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
            
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 10,),
                              child: Icon(Icons.notifications_active_outlined,size: 30,)),
                          Text("Thông báo",style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  color: Colors.grey.withOpacity(0.3),
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 12,right: 12),
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){},
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:EdgeInsets.only(top: 10,bottom: 10),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.black54.withOpacity(0.3),
            
                                        )
                                    ),
                                    child: Icon(Icons.discount_outlined,color: Colors.orange,),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Khuyến mãi",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                                      Text("Chúc mừng bạn nhận được khuyến mãi mới",style: TextStyle(fontSize: 14),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap:(){

                        },
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:EdgeInsets.only(top: 10,bottom: 10),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.black54.withOpacity(0.3),
            
                                        )
                                    ),
                                    child: Icon(Icons.computer_outlined,color: Colors.orange,),
                                  ),
                                  SizedBox(width: 10,),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        children: [
                                          Container(
                                              alignment:Alignment.topLeft,child: Text("Hệ thống",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                                          Text("Thông báo cập nhật hệ thống",style: TextStyle(fontSize: 14),)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_right)
                          ],
                        ),
                      )
            
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.3),
                  height: 10,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 12,right: 12),
                    child: Text("Cập nhật chi tiết đơn hàng")),

                for( dathang x in lst)

                  InkWell(
                    onTap: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => thongtindonhang(don: x)),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orangeAccent.withOpacity(0.3))),
                      margin: EdgeInsets.only(left: 12,right: 12,top: 10),
                      child:
                      Row(
                        children: [
                          Image.asset("images/caphe_dennong.jpg",height: 70,width: 70,),
                          Column(children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("Đơn hàng của bạn đã được xác nhận")),
                            Text("Đơn hàng của bạn sẽ sớm được giao đến địa chỉ"),
                            Text("${x.ad_nhan}"),
                            Text("Thời gian đặt hàng"" ${x.times}")
                          ],)
                        ],


                      ),
                    ),
                  )
              ]

            ),
          )


        )

    );
  }

}
