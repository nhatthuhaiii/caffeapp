import 'package:caffeapp/provider/cart.dart';
import 'package:caffeapp/provider/detail_drink.dart';
import 'package:caffeapp/src/detail.dart';
import 'package:caffeapp/ui/main_screen/Screen_Login/signintabs.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../provider/user_provider.dart';
import '../../../src/cafe.dart';

class singleitems extends StatefulWidget {
  singleitems({super.key, required this.data,this.fv=false});

  Caffe? data;
  bool ? fv;
  @override
  State<singleitems> createState() => _singleitemsState();
}

class _singleitemsState extends State<singleitems> {

  List<String> lst = ["S ", "M" ,"L "];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<DetailDrinkProvider>().price = (widget.data?.gia) ?? 0;
    context.read<DetailDrinkProvider>().priceDefault = (widget.data?.gia) ??0;
    Future.microtask(() {
      Provider.of<DetailDrinkProvider>(context, listen: false)
          .setFv(value: widget.fv ?? false);
    });


  }

  @override
  Widget build(BuildContext context) {
    Caffe? items = widget.data;
    double heigt = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Selector<DetailDrinkProvider,Tuple4<bool,int,int,int>>(
        selector: (BuildContext context, value) {

          return Tuple4(value.fv,value.SelectionSize,value.priceCalculate,value.sl);
        },
        builder: (BuildContext context, value, Widget? child) {

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(

                              alignment: Alignment.center,
                              height: heigt / 2,
                              width: width,
                              child: Image.network(
                                  "${widget.data?.url}",
                                  fit: BoxFit.fitWidth,
                                errorBuilder: (context, error, stackTrace){
                                  return Image.asset("images/brand_logo2.jpg", fit: BoxFit.fitWidth);
                                }
                              )
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              context.read<DetailDrinkProvider>().clear();

                            },
                            child: Ink(
                              child: Container(
                                  alignment: Alignment.topRight,
                                  padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                                  child: const Icon(Icons.close,
                                      color: Colors.black, size: 25)),
                            ),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.5),
                              offset: const Offset(0, 1))
                        ]),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      "${widget.data?.ten}",
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(right: 8),
                                      child: InkWell(
                                          onTap: () {
                                            if(context.read<user_provider>().userinfo== null){
                                              showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>FractionallySizedBox(
                                                heightFactor: 0.9,
                                                child: singinTabs(),
                                              ) );
                                              return;

                                            }

                                            context
                                                .read<DetailDrinkProvider>()
                                                .clickfv(username : context.read<user_provider>().userinfo!.userName, nameProducts: widget.data!.ten);
                                          },
                                          child: Icon(
                                              value.item1
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              size: 30,
                                              color: value.item1
                                                  ? Colors.orangeAccent
                                                  : Colors.black54)),
                                    ))
                              ],
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "${widget.data?.gia}.000đ",
                                style: TextStyle(fontSize: 20, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12, right: 12),
                              child: Text(
                                "${widget.data?.mota}",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          margin: EdgeInsets.only(left: 12,right: 12),
                          child: Text("Size",style: TextStyle(fontSize: 26),)),
                  Column(
                    children: [
                      CheckboxListTile(
                        title:  Text("Small"),
                        value:value.item2==1,
                        onChanged: (bool? value) {
                          context.read<DetailDrinkProvider>().setSelectionSize(1);
                        },
                      ),
                      CheckboxListTile(
                        title: Text("Medium"),
                        value: value.item2==2,
                        onChanged: (bool? value) {
                          context.read<DetailDrinkProvider>().setSelectionSize(2);
                        },
                      ),
                      CheckboxListTile(
                        title: Text("Large"),
                        value: value.item2==3,
                        onChanged: (bool? value) {
                          context.read<DetailDrinkProvider>().setSelectionSize(3);
                        },
                      ),
                    ],
                  ),









                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.5),
                              offset: const Offset(0, 1))
                        ]
                        ),


                        child: Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(left: 12, top: 10),
                            child: const Text(
                              "Yêu Cầu Khác",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                          ),


                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   margin: const EdgeInsets.only(left: 15),
                          //   child: const Text(
                          //     "Thêm Ghi Chú",
                          //     style: TextStyle(color: Colors.grey),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 8,
                          ),

                          Container(
                            padding: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(left: 12, right: 12),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Thêm Ghi Chú",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                        ]),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () => context
                                    .read<DetailDrinkProvider>()
                                    .removeDrink(),
                                child: Ink(
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.7),
                                        borderRadius:
                                        BorderRadius.circular(50)),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                value.item4.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              InkWell(
                                onTap: () => context
                                    .read<DetailDrinkProvider>()
                                    .addDrink(),
                                child: Ink(
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.7),
                                        borderRadius:
                                        BorderRadius.circular(50)),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: () {
                                  if(context.read<user_provider>().userinfo== null){
                                    showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>FractionallySizedBox(
                                      heightFactor: 0.9,
                                      child: singinTabs(),
                                    ) );
                                    return;

                                  }
                                   String size = value.item2 == 1 ? "S" :value.item2==2 ?"M":"L";
                                    detail a = new detail(items!, value.item4,size);


                                  context.read<cart>().addItems(a);

                                  //print(context.read<cart>().lst);
                                  Navigator.pop(context);
                                },
                                child: Text(value.item3 == 0
                                    ? "Chọn " +
                                    widget.data!.gia.toString() +
                                    ".000VNĐ"
                                    : "Chọn " +
                                    value.item3.toString() +
                                    ".000VNĐ")),
                          ),
                        )),
                  ],
                )
              )
            ],
          );
        }
      ),
    ));
  }
  DropdownMenuItem<String> buidMenu(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
}



