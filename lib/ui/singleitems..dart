import 'package:caffeapp/provider/cart.dart';
import 'package:caffeapp/provider/detail_drink.dart';
import 'package:caffeapp/src/detail.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../src/cafe.dart';

class singleitems extends StatefulWidget {
  singleitems({super.key, required this.data});

  caffe? data;

  @override
  State<singleitems> createState() => _singleitemsState();
}

class _singleitemsState extends State<singleitems> {
  String? size="M";
  List<String> lst = ["S ", "M" ,"L "];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<DetailDrinkProvider>().price = widget.data?.gia ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    caffe? items = widget.data;
    double heigt = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
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
                          child: Image.asset(
                            "${widget.data?.url}",
                                fit: BoxFit.fitWidth
                          )
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          context.read<DetailDrinkProvider>().clear();
                          //print("ok");
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
                                child: Selector<DetailDrinkProvider, bool>(
                              selector: (BuildContext, values) {
                                return values.fv;
                              },
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                return Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 8),
                                  child: InkWell(
                                      onTap: () {
                                        context
                                            .read<DetailDrinkProvider>()
                                            .clickfv();
                                      },
                                      child: Icon(
                                          value
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 30,
                                          color: value
                                              ? Colors.green
                                              : Colors.black)),
                                );
                              },
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
                  Container(
                    margin: EdgeInsets.only(left: 12,right: 12),
                    child: DropdownButton<String>(
                      value: size,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      items: lst.map(buidMenu).toList(),
                      onChanged: (value) =>
                          setState(() => this.size = value),
                    ),
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


                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "Thêm Ghi Chú",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
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
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            height: 70,
            child: Selector<DetailDrinkProvider, Tuple2<int, int>>(
              selector: (_, state) {
                return Tuple2(state.sl, state.total);
              },
              builder: (context, value, child) {
                return Row(
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
                                value.item1.toString(),
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
                                  detail a = new detail(items!, value.item1,size!);

                                  context.read<cart>().addItems(a);

                                  print(context.read<cart>().lst);
                                  Navigator.pop(context);
                                },
                                child: Text(value.item2 == 0
                                    ? "Chọn " +
                                        widget.data!.gia.toString() +
                                        ".000VNĐ"
                                    : "Chọn " +
                                        value.item2.toString() +
                                        ".000VNĐ")),
                          ),
                        )),
                  ],
                );
              },
            ),
          )
        ],
      ),
    ));
  }
  DropdownMenuItem<String> buidMenu(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
}



