import 'package:caffeapp/provider/cart.dart';
import 'package:caffeapp/provider/detail_drink.dart';
import 'package:caffeapp/src/detail.dart';
import 'package:caffeapp/ui/main_screen/Screen_search/searchtab.dart';
import 'package:caffeapp/ui/main_screen/Screen_Login/signintabs.dart';
import 'package:caffeapp/ui/main_screen/Screen_Carts/singleitems..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../provider/user_provider.dart';
import '../../../src/cafe.dart';
import '../../../provider/getData.dart';
import '../Screen_Notifi/notifitabs.dart';
import '../Screen_orderProduct/orderdetail.dart';
class carttabs extends StatefulWidget {
  carttabs({super.key});

  @override
  State<carttabs> createState() => _carttabsState();
}

class _carttabsState extends State<carttabs> {
  @override
  List<Caffe> lst =[];
  void initState() {
    // TODO: implement initState
    super.initState();
   // var x = context.read<getData>().getList();
    lst = context.read<getData>().listcaffe;
  }
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Selector<cart, Tuple3<List<detail>,int,int>>(
          selector: (BuildContext context, values) {
            return Tuple3(values.lst, values.tong,values.gia);
          },
          builder: (BuildContext context, value, Widget? child) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 12, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.shopping_bag_outlined,size: 30,)),
                              Text(
                                "Sản Phẩm",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 12),
                            child: InkWell(
                              onTap: (){
                                if(context.read<user_provider>().userinfo== null){
                                  showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>FractionallySizedBox(
                                    heightFactor: 0.9,
                                    child: singinTabs(),
                                  ) );
                                  return;

                                }

                                Navigator.push(context, MaterialPageRoute(builder: (context)=> notifitabs()));
                              },
                              child: Icon(Icons.notifications_active_outlined,color: Colors.black87,size: 30,),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 5,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellowAccent.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(left: 5),
                      height: 50,
                      child: TextFormField(
                        readOnly: true,
                        style: TextStyle(color: Colors.black.withOpacity(0.8)),
                        onTap: (){
                          showSearch(context: context, delegate: searchcaffe());
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tìm Kiếm",
                          hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black.withOpacity(0.3),
                          ),

                        ),

                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(left: 12, top: 5),
                                
                                child: const Text(
                                  "Sản phẩm",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                     ),
                                )),
                            for (int i = 0; i < lst.length; i++)
                            //buildItem("${lst[i].url}")
                              Selector<DetailDrinkProvider,List<String>>(
                                builder: (BuildContext context, List<String> value, Widget? child) {
                                  return
                                    InkWell(
                                    onTap: () {

                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            final isfv = value.contains(lst[i].ten);
                                            return FractionallySizedBox(
                                              heightFactor: 0.9,
                                              child: singleitems(
                                                data: lst[i],
                                                fv: isfv,
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      //padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(
                                          left: 12, top: 10, right: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.yellowAccent.withOpacity(0.3)),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white12,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            margin: const EdgeInsets.only(
                                                left: 8, top: 8, bottom: 8),
                                            child: Image.network(
                                              "${lst[i].url}",
                                              height: 90,
                                              width: 90, errorBuilder: (BuildContext, Object, StackTrace? stackTrace) {
                                                  return Image.asset(
                                                    "images/brand_logo2.jpg",
                                                    height: 100,
                                                    width: 100,
                                                  );
                                                }
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                    EdgeInsets.only(bottom: 10),
                                                    child: Text("${lst[i].ten}"),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                            "${lst[i].gia}" +
                                                                ".000VNĐ"),
                                                      ),
                                                      InkWell(
                                                        onTap: (){
                                                          if(context.read<user_provider>().userinfo == null){
                                                            showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>FractionallySizedBox(
                                                              heightFactor: 0.9,
                                                              child: singinTabs(),
                                                            ) );
                                                            return;

                                                          }
                                                          detail a = detail(lst[i], 1,"M");
                                                          context.read<cart>().addItems(a);


                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          margin: EdgeInsets.only(
                                                              right: 10),
                                                          decoration: BoxDecoration(
                                                              color: Colors.orange,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(20)),
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 20,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                },
                                selector: (BuildContext , DetailDrinkProvider ) {
                                  return DetailDrinkProvider.lstfv;
                                },

                              )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: value.item1.length>0 ,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white60.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                          )
                        ],
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(left: 12, right: 12, bottom: 5),
                      height:45,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.orange,
                            size: 30,
                          ),
                          Container(
                            height: 40,
                            child: Column(
                              children: [
                                Text("GREEN CAFFE" ,style: TextStyle(fontSize: 12,color: Colors.orange,fontWeight: FontWeight.bold),),
                                Text("Xin mời đặt hàng",style: TextStyle(fontSize: 10,color: Colors.orange),)
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              showModalBottomSheet(context: context,
                                  isScrollControlled: true,
                                  builder: (context){

                                    return FractionallySizedBox(
                                      heightFactor: 0.95,
                                      child: orderdetail(),
                                    );
                                  }
                              );


                            },
                            child: Container(

                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(30),

                              ),
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Container(

                                    alignment: Alignment.center,
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color:Colors.white ,
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: Text(

                                      value.item2.toString(),style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                  Container(

                                    margin: EdgeInsets.only(right: 8,left: 6),

                                    child: Text("${value.item3}.000VNĐ"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );;
  }
}


