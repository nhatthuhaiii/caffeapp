import 'package:caffeapp/src/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/dathang.dart';

class thongtindonhang extends StatefulWidget {
  thongtindonhang({super.key, required this.don});

  dathang don;

  @override
  State<thongtindonhang> createState() => _thongtindonhangState();
}

class _thongtindonhangState extends State<thongtindonhang> {

  late dathang data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.don;


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      )),
                ),
                Text(
                  "Thông tin đơn hàng",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12, top: 10),
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Đơn hàng đang chuẩn bị",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Thông cảm cho quán và các shipper bạn nhé",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(left: 12, right: 12, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Từ"),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Coffe Home",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${widget.don!.ad_dat}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.3),
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(left: 12, right: 12, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Đến"),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${widget.don!.ad_nhan}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Tên: ${widget.don!.nguoinhan}",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black12.withOpacity(0.8)),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Điện thoại: ${widget.don!.sdt}",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black12.withOpacity(0.8)),
                          )),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.3),
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 1),
                  child: Column(
                    children: [],
                  ),
                ),
                for (detail x in widget.don.lst)
                  Container(
                    color: Colors.red,
                    height: 100,
                    width: 100,
                    child: Text("${x.a.ma}"),
                  )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
