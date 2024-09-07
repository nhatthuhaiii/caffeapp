import 'dart:convert';

import 'package:caffeapp/provider/statusOrder.dart';
import 'package:caffeapp/src/detail.dart';
import 'package:caffeapp/ui/main_screen/Screen_Notifi/notifitabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../provider/cart.dart';
import '../../../../src/dathang.dart';
import 'package:http/http.dart' as http;


import '../../../cafeapp.dart';

class thongtindonhang extends StatefulWidget {
  thongtindonhang({super.key, required this.don});

  dathang don;

  @override
  State<thongtindonhang> createState() => _thongtindonhangState();
}

class _thongtindonhangState extends State<thongtindonhang>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  dathang? data;

  late double store_lat;
  late double store_long;


  @override
  @override
  void dispose() {
    // TODO: implement dispose


    data = null;
    _controller.dispose();


   // context.read<statusOrder>().clearorder();
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    data = widget.don;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<statusOrder>().updateStage(data!.trangthai!);
    });
    print("1 + ${data!.ad_nhan!}");



    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  void animateProgress() {
    _controller.forward(from: 0);
  }


  Widget buildIcon(IconData icon, bool isActive) {
    return Column(
      children: [
        Icon(icon, color: isActive ? Colors.green : Colors.grey),
        const SizedBox(height: 4),

      ],
    );
  }

  Widget buildAnimatedLine(bool isActive, int index, int currentIndex) {
    return Expanded(
      child: Container(
        height: 4,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            double fill = 0;
            if (index < currentIndex) {
              fill = 1;
            } else if (index == currentIndex) {
              fill = _animation.value;
            }
            return Stack(
              children: [
                Container(height: 4, color: Colors.grey[300]),
                FractionallySizedBox(
                  widthFactor: fill,
                  child: Container(height: 4, color: Colors.blue),
                )
              ],
            );
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // final stageProvider = Provider.of<statusOrder>(context);
    // stageProvider.updateStage(data!.trangthai!);
    // final currentIndex = stageProvider.currentIndex;

    List<IconData> icons = [
      Icons.pending_actions,
      Icons.verified,
      Icons.local_shipping,
      Icons.check_circle, // giao hàng thành công
    ];
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child:


            Column(
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
                                    "Đơn hàng  ${widget.don.trangthai}",
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
                                    TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:EdgeInsets.only(left: 12,top: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Trạng thái đơn hàng",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                        ),
                      ),
                      Selector<statusOrder, int>(
                          selector: (_, provider) => provider.currentIndex,
                          builder: (_, currentIndex, __) {
                            return Container(
                              margin: EdgeInsets.only(left: 12,right: 12,top: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    icons.length * 2 - 1, (i) {
                                  if (i.isEven) {
                                    return buildIcon(
                                        icons[i ~/ 2], i ~/ 2 <= currentIndex);
                                  } else {
                                    return buildAnimatedLine(
                                        true, i ~/ 2, currentIndex);
                                  }
                                }),
                              ),
                            );
                          },
                        ),
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        height: 10,
                      ),
                                          widget.don.shipper != null
                                            ?
                                        Container(
                                          margin:EdgeInsets.only(left: 12,right: 12,top: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Row(
                                                children: [
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    decoration: BoxDecoration(
                                                        color: Colors.orangeAccent,
                                                        borderRadius: BorderRadius.circular(
                                                            50)),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text("Shipper",style: TextStyle(fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              Text("tên:  " + "${widget.don.shipper!.name}"),
                                              Text("Số điện thoại:  " +
                                                  "${widget.don.shipper!.phone}"),

                                            ],
                                          ),
                                        ) : Container(),



                          Container(
                            color: Colors.grey.withOpacity(0.3),
                            height: 10,
                          ),
                          Container(
                            //padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                              50)),
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${widget.don.ad_dat!.diachi}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey.withOpacity(0.3),
                            height: 10,
                          ),
                          Container(

                            margin: EdgeInsets.only(left: 12, right: 12,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(
                                              50)),
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
                                      "${widget.don!.ad_nhan }",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Tên: ${widget.don!.nguoinhan!.name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black12.withOpacity(
                                              0.8)),
                                    )),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Điện thoại: ${widget.don!.sdt}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black12.withOpacity(
                                              0.8)),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey.withOpacity(0.3),
                            height: 10,
                          ),



                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 12, right: 12),
                                child: Text(
                                    "Chi tiết đơn hàng", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                          ),

                          Column(
                            children: [
                              for(detail x in widget.don.lst)
                                Container(
                                  margin: EdgeInsets.only(left: 12, right: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${x.a.ten}" + " x" + "${x.sl}"),
                                            Text("Size: ${x.size}"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Text("${x.a.gia}.000VNĐ"),
                                      )
                                    ],
                                  ),
                                ),

                            ],
                          ),


                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          children: [


                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                SizedBox(width: 5),
                                Text("Thành tiền"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Giá sản phẩm : "),
                                Text("${widget.don.gia}.000VNĐ")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Giảm giá : "),
                                Text("${widget.don.giamgia == 1
                                    ? "0VNĐ"
                                    : formatCurrency(widget.don.giamgia!)
                                    .toString()}")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Phí giao hàng : "),
                                Text("${widget.don.phigiaohang}.000VNĐ")
                              ],
                            ),
                            Divider(color: Colors.black),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tổng Cộng : ",
                                  style: TextStyle(fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(widget.don.giamgia == 1 ? "${(widget.don
                                    .gia! + widget.don!.phigiaohang!)
                                    .toString() + ".000VNĐ"}" :

                                "${(widget.don!.gia! +
                                    widget.don!.phigiaohang! -
                                    widget.don!.giamgia!).toString() +
                                    "00VNĐ"}",
                                  style: TextStyle(fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              child: Text(
                                "Thanh toán : ${widget.don.thanhtoan}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.don.trangthai!.toLowerCase() == "chờ xác nhận" ?Expanded(
                                  child: InkWell(
                                    onTap: () async{
                                      await FirebaseFirestore.instance
                                          .collection('orderdetail')
                                          .doc(widget.don.id)
                                          .update({'trangthai': 'bị huỷ', });
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> notifitabs()));

                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin:EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.red),
                                          color:Colors.white,borderRadius: BorderRadius.circular(10)),
                                      child: Center(child: Text("Huỷ đơn hàng", style: TextStyle(color: Colors.red),)),
                                    ),
                                  ),
                                ):Container(),

                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> caffeapp(currentPage: NavigationPages.home)));

                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin:EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(10)),
                                      child: Center(child: Text("trở về màn hình chính", style: TextStyle(color: Colors.white),)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )


                      ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  String tinhTienSauGiamGia(String ma, bool isme, double discountPrice) {
    double tongTien = (context.read<cart>().tinhtien() as int).toDouble();
    double tienGiamGia = tongTien * discountPrice;
    double finalAmount = 0;

    if (ma == "" && isme == false) {
      finalAmount = tongTien + 10;
    } else if (ma != "" && isme == false) {
      finalAmount = tongTien + 10 - tienGiamGia;
    } else if (ma == "" && isme == true) {
      finalAmount = tongTien + 15;
    } else if (ma != "" && isme == true) {
      finalAmount = tongTien + 15 - tienGiamGia;
    } else {
      finalAmount = tongTien; // Trường hợp dự phòng
    }

    return formatCurrency(finalAmount);
  }

  String formatCurrency(double amount) {
    String formatted = amount.toStringAsFixed(3);
    return "$formatted VND";
  }
}
