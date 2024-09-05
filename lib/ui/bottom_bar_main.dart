import 'package:caffeapp/provider/cart.dart';
import 'package:caffeapp/src/cuahang.dart';
import 'package:caffeapp/src/detail.dart';
import 'package:caffeapp/ui/searchtab.dart';
import 'package:caffeapp/ui/singleitems..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../src/cafe.dart';

import 'orderdetail.dart';

class hometab extends StatefulWidget {
  const hometab({super.key});

  @override
  State<hometab> createState() => _hometabState();
}

class _hometabState extends State<hometab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hometabpage(),
    );
  }
}

class hometabpage extends StatefulWidget {
  hometabpage({super.key});

  @override
  State<hometabpage> createState() => _hometabpageState();
}

class _hometabpageState extends State<hometabpage> {
  List<caffe> lst = caffe.getList();
  bool setting = false;

  @override

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white70,
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
                        margin: EdgeInsets.only(left: 12, top: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.coffee_outlined,
                              color: Colors.black,
                              size: 32,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                "Chào bạn mới!",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 5),
                          margin: EdgeInsets.only(left: 12, right: 12, top: 5),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white60,
                              border: Border.all(color: Colors.yellowAccent.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            style: TextStyle(color: Colors.green),

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Tìm Kiếm",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.3)),
                              prefixIcon: InkWell(
                                  onTap: () {
                                    showSearch(
                                        context: context,
                                        delegate: searchcaffe());
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black.withOpacity(0.3),
                                  )),
                            ),
                            // tim kiem

                            onTap: () {
                              showSearch(
                                  context: context, delegate: searchcaffe());
                            },
                          )),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              height: 200,
                              padding: EdgeInsets.all(8),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    height: 150,
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Image.asset(
                                      "images/quangcao1.jpg",
                                    ),
                                  ),
                                  Container(
                                    height: 150,
                                    margin: const EdgeInsets.only(left: 10),
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Image.asset(
                                      "images/quangcao2.jpg",
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            Container(
                              margin: EdgeInsets.only(bottom: 5, left: 12,top :10),
                              child: Text(
                                "Món Mới Phải Thử",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),


                         //   SizedBox(height: 10,),
                            GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 1.6),
                              children: [
                                for (int i = 0; i < lst.length/2; i++)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 13),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.yellowAccent.withOpacity(0.35)),
                                        color: Colors.white60.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: []),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context) {
                                                    return FractionallySizedBox(
                                                      heightFactor: 0.9,
                                                      child: singleitems(
                                                          data: lst[i]),
                                                    );
                                                  });
                                            },
                                            child: Container(





                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Image.asset(
                                                "${lst[i].url}",
                                                width: 140,
                                                height: 130,
                                                fit: BoxFit.fill,

                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 5,bottom: 5),
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "${lst[i].ten}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black.withOpacity(0.8),

                                                          ),
                                                ),
                                              ),
                                              // Container(
                                              //   alignment: Alignment.topLeft,
                                              //     child: Text("Best Seller",style: TextStyle(fontSize: 10),)),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        "${lst[i].gia}" + ".000VNĐ",
                                                        style: TextStyle(
                                                          fontSize: 14  ,
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          color: Colors.black.withOpacity(0.8),
                                                          //fontStyle:
                                                            //  FontStyle.italic,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        detail a =
                                                            detail(lst[i], 1,"M");
                                                        context
                                                            .read<cart>()
                                                            .addItems(a);
                                                       // Navigator.pop(context);
                                                        setState(() {

                                                        });
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.orange,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Icon(
                                                            CupertinoIcons.add,
                                                            color: Colors.white,
                                                            size: 20,
                                                          )),
                                                    ),
                                                  ]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
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

                                          value.item2.toString(),style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Container(

                                      margin: EdgeInsets.only(right: 8,left: 6),

                                      child:Text(value.item3.toString()+".000VNĐ"),
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
          )),
    );
  }
}
