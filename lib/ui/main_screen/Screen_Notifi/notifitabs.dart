import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/provider/shipper.dart';
import 'package:caffeapp/provider/statusOrder.dart';
import 'package:caffeapp/ui/main_screen/Screen_Notifi/Screen_Discount/disscouttabs.dart';
import 'package:caffeapp/ui/main_screen/Screen_Notifi/Screen_System/systemtabs.dart';
import 'package:caffeapp/ui/main_screen/Screen_Notifi/Screen_orderDetail/thongtindonhang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../../../src/dathang.dart';

class notifitabs extends StatefulWidget {
     notifitabs({super.key});

  @override
  State<notifitabs> createState() => _notifitabsState();
}

class _notifitabsState extends State<notifitabs> {
  @override
  List<dathang>? lst ;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    print("${context.read<user_provider>().userinfo!.userName}");



    _getList();
  }

  void _getList ()async {

  lst = await context.read<shipper>().getOrdersByUsername(context.read<user_provider>().userinfo!.userName);
  lst?.sort((a, b) => b.times!.compareTo(a.times!));
  setState(() {

  });
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(

        child: Scaffold
          (
          appBar: AppBar(
            title: Text("Thông Báo"),

          ),
          body:SingleChildScrollView(
            child:


            Column(

              children: [

                Container(
                  color: Colors.grey.withOpacity(0.3),
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 12,right: 12),
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context)=> disscouttabs())

                          );
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
                                    child: Icon(Icons.discount_outlined,color: Colors.orange,),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Khuyến mãi",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                                      Container(
                                          child: Text("Chúc mừng bạn nhận được khuyến mãi mới",style: TextStyle(fontSize: 14),))
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
                             Navigator.push(context, MaterialPageRoute(builder: (context) => systemtabs()),);
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                              alignment:Alignment.topLeft,child: Text("Hệ thống",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                                          Text("Thông báo hệ thống",style: TextStyle(fontSize: 14),)
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
                lst==null || lst!.length ==0
                    ?Center(child: Text("bạn chưa có đơn hàng nàoooo"),):

                Selector<getData,List<dathang>>(



                  builder: (BuildContext context, List<dathang> value, Widget? child) {

                    return Column(
                    children: [
                    Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 12,right: 12,top:10),
                    child: Text("Lịch sử đặt hàng")),


                    for( dathang x in value!)

                    InkWell(
                    onTap: (){

                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => thongtindonhang(don: x)),
                    ).then((_){ context.read<statusOrder>().clearorder();});
                    },
                    child: Container(

                    child: Column(
                    children: [
                    Container(
                    padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.orangeAccent
                                                      .withOpacity(0.3))),
                                          margin: EdgeInsets.only(
                                              left: 12, right: 12, top: 10),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "images/caphe_dennong.jpg",
                                                height: 80,
                                                width: 80,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Mã đơn hàng HĐ${x.id!.substring(8, x.id!.length - 3)}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                        "Đơn hàng của bạn  giao đến địa chỉ:${x.ad_nhan}"),
                                                    Text(
                                                        "Địa chỉ đặt hàng: ${x!.ad_dat!.diachi}"),
                                                    Text("Thời gian đặt hàng"
                                                        " ${x.getFormattedTime()}"),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                        selector: (BuildContext , getData ) { return getData.listdonhang; },





                )



              ]

            ),
          )


        )

    );
  }

}
