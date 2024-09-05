import 'package:caffeapp/provider/cart.dart';
import 'package:caffeapp/provider/shipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../src/cafe.dart';
import '../src/cuahang.dart';
import '../src/dathang.dart';
import '../src/detail.dart';

class orderdetail extends StatefulWidget {
  const orderdetail({super.key});

  @override
  State<orderdetail> createState() => _orderdetailState();
}

class _orderdetailState extends State<orderdetail> {
  @override
  List<detail> lst = [];
  final List<String> items = cuahang.getDiachiAll(cuahang.getList());
  String? values = "58 Lâm Văn Bền, Phường Tân Kiểng, Quận 7, Hồ Chí Minh";
  String? val_aduser;
  String? phone;
  String? name;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    lst = context.read<cart>().lst;
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Selector<cart, Tuple2<int, int>>(
      selector: (BuildContext context, value) {
        return Tuple2(value.gia, value.tong);
      },
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<cart>().clear();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Xoá",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8)),
                          ),
                        ),
                        Text(
                          "Xác nhận đơn hàng ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.3),
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, right: 12),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Giao Hàng",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8)),
                            )),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Địa chỉ nhận hàng",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8)),
                            )),
                        TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            onChanged: (value) {
                              name = value;
                              //print(val_aduser);
                            },
                            decoration: InputDecoration(
                              hintText: "Tên người nhận",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8)),
                            )),
                        TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            onChanged: (value) {
                             phone = value;
                          //    print(val_aduser);
                            },
                            decoration: InputDecoration(
                              hintText: "Số điện thoại",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8)),
                            )),
                        TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            onChanged: (value) {
                             val_aduser = value;
                             // print(val_aduser);
                            },
                            decoration: InputDecoration(
                              hintText: "Địa chỉ nhận hàng",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8)),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Địa chỉ đặt hàng",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8)),
                            )),
                        Container(
                          child: DropdownButton<String>(
                            value: values,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            items: items.map(buidMenu).toList(),
                            onChanged: (value) =>
                                setState(() => this.values = value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.3),
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, right: 12, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Sản phẩm đã chọn",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8)),
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "+ Thêm",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  for (detail x in lst)
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Row(

                           children: [
                             IconButton(
                                 onPressed: () {
                                   context.read<cart>().xoaIt(x);

                                   setState(() {});
                                   if (lst.length == 0) {
                                     Navigator.pop(context);
                                   }
                                 },
                                 icon: Icon(
                                   Icons.close,
                                   size: 16,
                                 )),

                             Column(
                               children: [
                                 Container(
                                     alignment: Alignment.topLeft,
                                     child: Text(
                                       "x${x.sl}" " " "${x.a.ten}",
                                       style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 14),
                                     )),
                                 Text("${x.size}")
                               ],
                             ),
                           ],
                         ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    child: Text(
                                        "${(x.a.gia! * x.sl).toString()}.000vnđ"),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  Container(
                    color: Colors.grey.withOpacity(0.3),
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, right: 12, top: 10),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Tổng Cộng",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thành Tiền"),
                              Text("${value.item1}.000VNĐ")
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Phí giao hàng"), Text("0VNĐ")],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Số tiền cần thành toán",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${value.item1}.000VNĐ")
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 10, right: 12, left: 12),
              color: Colors.orangeAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("${value.item2} sản phẩm",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text(
                        "${value.item1}.000VNĐ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {

                      dathang a = new dathang(lst, values!, val_aduser!,name!,phone!);

                      context.read<shipper>().addList(a);
                      context.read<cart>().clear();


                      if (context.read<cart>().gia == 0) {
                        Navigator.pop(context);
                      }
                      setState(() {

                      });
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(

                                title: Text("Thông Báo"),
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 12, right: 12),
                                    child: Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                              "Đơn hàng của bạn sẽ sớm được giao đến địa chỉ: "),
                                          Text("${val_aduser}"),
                                          InkWell(
                                            child: Text("Đóng"),
                                            onTap: () {
                                              var nav = Navigator.of(context);
                                              nav.pop();
                                           //   nav.pop();
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ));



                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                        "Đặt Hàng",
                        style: TextStyle(fontSize: 16, color: Colors.orange),
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    )));
  }

  DropdownMenuItem<String> buidMenu(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
}
