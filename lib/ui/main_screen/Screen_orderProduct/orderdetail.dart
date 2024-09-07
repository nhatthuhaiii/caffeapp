import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:caffeapp/provider/cart.dart';
import 'package:caffeapp/provider/order_provider.dart';
import 'package:caffeapp/provider/shipper.dart';
import 'package:caffeapp/provider/user_provider.dart';
import 'package:caffeapp/src/user.dart';
import 'package:caffeapp/ui/main_screen/Screen_orderProduct/Screen_updateProduct/screenupdate.dart';
import 'package:caffeapp/ui/main_screen/Screen_Notifi/Screen_orderDetail/thongtindonhang.dart';
import 'package:caffeapp/ui/services/service_vnpay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;


import '../../../provider/getData.dart';
import '../../../src/Discount.dart';
import '../../../src/cafe.dart';
import '../../../src/cuahang.dart';
import '../../../src/dathang.dart';
import '../../../src/detail.dart';

class orderdetail extends StatefulWidget {
  const orderdetail({super.key});

  @override
  State<orderdetail> createState() => _orderdetailState();
}

class _orderdetailState extends State<orderdetail> {
  @override
  List<detail> lst = [];
  late  List<cuahang> items = [];
  late cuahang? values_store = items.first;
  String? val_aduser;
  String? phone;
  String? name;
  String? namenew;
  String? phonenew;
  late Position user_location ;
  String location = "";
  // bool isMeSelected = false;
  List<Discount> discounts = [];
  String discountname = "";
  double discountPrice = 1;
  double deliveryDistance = 0.0;
  double deliveryFee = 0.0;
  Timer ? debouceTimer;



  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    lst = context.read<cart>().lst;
    phone = context.read<user_provider>().userinfo!.phoneNumber;
    name = context.read<user_provider>().userinfo!.name;
    items= context.read<getData>().listcuahang;
    discounts = context.read<getData>().listdiscount;
  }
  // void _handleLocationSelection() {
  //   if (!isMeSelected) {
  //     setState(() {
  //       isMeSelected = true;
  //     });
  //   }
  //   getLocation();
  // }

  // Future<void> getdistanceString (String addres)  async {
  //   deliveryFee = 0;
  //   Position? position = await getLatLngFromGraphHopper(addres);
  //   print(position);
  //   if(position!= null) {
  //     deliveryDistance = Geolocator.distanceBetween(
  //         values_store!.lattidude!, values_store!.longatitude!, position.latitude, position.longitude);
  //     print(deliveryDistance);
  //     deliveryDistance = deliveryDistance / 1000;
  //     deliveryFee = calculateFare(deliveryDistance);
  //   }
  //   setState(() {
  //
  //   });
  // }


  // Future<void> getLocation () async {
  //
  //   Position us =  await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //     // time out
  //     timeLimit: Duration(seconds: 3),
  //   );
  //   if(us !=null) {
  //     final pos = await getAddressFromLatLng(us);
  //
  //     double storeLat = values_store!.lattidude!;
  //     double storeLong = values_store!.longatitude!;
  //
  //     setState(() {
  //       user_location = us;
  //       location = pos;
  //       deliveryDistance = Geolocator.distanceBetween(us.latitude, us.longitude, storeLat, storeLong) / 1000;
  //     });
  //   }
  //
  //   print(discounts.length);
  //   print(user_location);
  //
  //
  //
  //
  // }

  // Future<Position?> getLatLngFromGraphHopper(String address) async {
  //   String apiKey = "ec614973-73ab-42f6-8fe4-a5ba3c05cb39"; // Thay bằng API Key thật
  //   String url =
  //       "https://graphhopper.com/api/1/geocode?q=${Uri.encodeComponent(address)}&limit=1&key=$apiKey";
  //
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       if (data["hits"].isNotEmpty) {
  //         var location = data["hits"][0]["point"];
  //         return Position(
  //           latitude: location["lat"],
  //           longitude: location["lng"],
  //           timestamp: DateTime.now(), // Giá trị bắt buộc
  //           accuracy: 0.0, // Accuracy không có, gán mặc định
  //           altitude: 0.0, // Không có độ cao, gán mặc định
  //           heading: 0.0,
  //           speed: 0.0,
  //           speedAccuracy: 0.0, altitudeAccuracy:0.0, headingAccuracy: 0.0 ,
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     print("Lỗi: $e");
  //   }
  //   return null;
  // }

  // Future<Position?> getLatLngFromAddress(String address) async {
  //   try {
  //     List<Location> locations = await locationFromAddress(address);
  //
  //     if (locations.isNotEmpty) {
  //       Location location = locations.first; // Lấy tọa độ đầu tiên tìm được
  //       return Position(
  //         latitude: location.latitude,
  //         longitude: location.longitude,
  //         timestamp: DateTime.now(), // Thêm thông tin thời gian nếu cần
  //         accuracy: 0.0, // Độ chính xác nếu có
  //         altitude:  0.0, // Độ cao nếu có
  //         heading:  0.0, // Hướng nếu có
  //         speed:  0.0, // Tốc độ nếu có
  //         speedAccuracy:  0.0,
  //         altitudeAccuracy:  0.0,
  //         headingAccuracy:  0.0, // Độ chính xác tốc độ nếu có
  //       );
  //     }
  //   } catch (e) {
  //     print("Lỗi: $e");
  //   }
  //   return null; // Trả về null nếu không tìm thấy vị trí
  // }









  // Future<String> getAddressFromLatLng(Position us) async {
  //   final url = Uri.parse("https://nominatim.openstreetmap.org/reverse?format=json&lat=${us.latitude}&lon=${us.longitude}");
  //   final response = await http.get(url);
  //
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final address = data["address"];
  //
  //     String houseNumber = address["house_number"] == null ? "" : address["house_number"].toString()+",";
  //     String road = address["road"].toString()+"," ?? "";
  //     String city = address["city"].toString()+"" "";
  //
  //     return "$houseNumber $road $city";
  //   }
  //
  //
  //   else {
  //     return "Lỗi khi lấy địa chỉ"+ response.statusCode.toString();
  //   }
  // }



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
                                        context.read<order_provider>().clearOrder();
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
                                child: Selector<user_provider,user?>(
                                  builder: (BuildContext context, value, Widget? child) {

                                    return Column(
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Địa chỉ nhận hàng",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black.withOpacity(0.8)),
                                                )),
                                            InkWell(
                                              onTap:(){



                                                context.read<order_provider>().useCurrentLocation();
                                                // _handleLocationSelection();

                                                print(location);
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [

                                                    Icon(Icons.location_on,color: Colors.red,),
                                                    Text("Me"),
                                                  ],
                                                ),
                                              ),
                                            )

                                          ],
                                        ),


                                        Selector<order_provider, Tuple2<String, bool>>(
                                          selector: (BuildContext context, order_provider provider) {
                                            return Tuple2(provider.locationAddress, provider.isLocationSelected);
                                          },
                                          builder: (BuildContext context, value, Widget? child) {
                                            return TextFormField(
                                              cursorColor: Colors.black,
                                              style: TextStyle(color: Colors.black),
                                              onChanged: (text) {
                                                context.read<order_provider>().setAddress(text);
                                              },
                                              decoration: InputDecoration(
                                                hintText: value.item2 ? value.item1 : "Nhập địa chỉ của bạn",
                                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                                              ),
                                            );
                                          },
                                        ),


                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Tên người nhận",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black.withOpacity(0.8)),
                                            )),
                                        TextFormField(

                                            cursorColor: Colors.black,
                                            style: TextStyle(color: Colors.black),



                                            onChanged: (value) {
                                              namenew = value;
                                              //print(val_aduser);
                                            },
                                            decoration: InputDecoration(

                                                hintStyle: TextStyle(

                                                    color: Colors.black.withOpacity(0.8)),
                                                hintText: "${value!.name}"
                                            )
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Số điện thoại người nhận",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black.withOpacity(0.8)),
                                            )),
                                        TextFormField(
                                            cursorColor: Colors.black,
                                            style: TextStyle(color: Colors.black),
                                            onChanged: (value) {
                                              phonenew = value;
                                              //    print(val_aduser);
                                            },
                                            decoration: InputDecoration(
                                              hintText: "${value.phoneNumber}",
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
                                        Selector<order_provider, cuahang?>(
                                          selector: (context, orderProvider) => orderProvider.selectedStore,
                                          builder: (context, selectedStore, child) {
                                            return DropdownButton<cuahang>(
                                              value: selectedStore, // Giá trị lấy từ Selector
                                              isExpanded: true,
                                              icon: Icon(Icons.arrow_drop_down),
                                              items: [
                                                DropdownMenuItem<cuahang>(
                                                  value: null, // Giá trị rỗng
                                                  child: Text('Chọn cửa hàng'),
                                                ),
                                                ...items.map((cuahang item) {
                                                  return DropdownMenuItem<cuahang>(
                                                    value: item,
                                                    child: Text(item.diachi),
                                                  );
                                                }).toList(),
                                              ],
                                              onChanged: (cuahang? value) {
                                                context.read<order_provider>().setStore(value!);
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  },
                                  selector: (BuildContext  context,values ) {
                                    return values.userinfo;
                                  },


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
                              Divider(),
                              for (detail x in context.watch<cart>().lst)
                                Slidable(
                                  startActionPane: ActionPane(
                                    motion: BehindMotion(),children: [
                                    SlidableAction(onPressed: (context){
                                      showModalBottomSheet(context: context, isScrollControlled: true,builder: (context)=> FractionallySizedBox(
                                        heightFactor: 0.4,
                                        child: screenupdate(data: x,),
                                      ));
                                    },icon: Icons.settings_outlined,backgroundColor: Colors.blue,)

                                  ],
                                  ),
                                  endActionPane: ActionPane(motion: BehindMotion(),

                                    children: [
                                      SlidableAction(onPressed: (context){

                                        context.read<cart>().xoaIt(x);



                                        if (lst.length == 0) {
                                          Navigator.pop(context);
                                        }
                                      },


                                        icon: Icons.remove,backgroundColor: Colors.red,)
                                    ],


                                  ),
                                  child: Container(

                                    margin: EdgeInsets.only(left: 12, right: 12, top: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Row(

                                          children: [

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
                                                Text("${x.size}"),
                                                Divider(),
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
                                                      "${x.size=="S"?(x.a.gia-5)*x.sl:
                                                      x.size=="M"?(x.a.gia)*x.sl
                                                          :(x.a.gia+5)*x.sl}.000vnđ"),


                                                ),
                                              ),
                                            ]),
                                      ],
                                    ),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Tổng Cộng",
                                              style: TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.bold),
                                            )),

                                        Container(

                                          width:  150,
                                          child: TextFormField(

                                            onChanged: (value){
                                              discountname = value ;
                                              var matchingDiscounts = discounts.where((discount) => discount.name == discountname);
                                              setState(() {
                                                if(matchingDiscounts.isNotEmpty){
                                                  discountPrice = matchingDiscounts.first.discountPrice;
                                                }
                                                else
                                                  discountPrice=0;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                suffixIcon: Icon(Icons.discount_outlined),
                                                hintText:"mã giảm giá"
                                            ),


                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Thành Tiền"),
                                          Text("${context.read<cart>().tinhtien()}.000VNĐ")
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Giảm giá"),
                                          Text("${discountname==""?"0VNĐ" : (formatCurrency(context.read<cart>().tinhtien()*discountPrice)).toString()}")
                                        ],
                                      ),
                                    ),
                                    Selector<order_provider,Tuple2<double,double>>(

                                      builder: (BuildContext context, Tuple2<double, double> value, Widget? child) {

                                        return Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [Text("Khoảng cách"),
                                                        Text("${value.item2.toStringAsFixed(2)}km")
                                                        // Text("${deliveryDistance.toStringAsFixed(2)}km")
                                                      ]
                                                  )
                                              ),

                                              Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [Text("Phí giao hàng"),

                                                      Text("${value.item1.round()}.000VNĐ")],
                                                  )
                                              ),
                                            ]);
                                      },

                                      selector: (BuildContext , order_provider ) {
                                        return Tuple2(order_provider.deliveryFee, order_provider.deliveryDistance);
                                      },

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
                                          Text("${tinhTienSauGiamGia(discountname, context.read<order_provider>().isLocationSelected, discountPrice) }VNĐ",style: TextStyle(fontWeight: FontWeight.bold),)
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


                            Selector<order_provider,int>(
                              builder: (BuildContext context, int value, Widget? child) {
                                return                               Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 12,top:10),
                                        child: Text("Phương thức thanh toán",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                                    CheckboxListTile(
                                      title:  Row(
                                        children: [
                                          Icon(Icons.local_shipping_outlined,color: Colors.orangeAccent,),
                                          SizedBox(width: 10,),
                                          Text("Thanh toán khi nhận hàng"),
                                        ],
                                      ),
                                      value:value==1,
                                      onChanged: (bool? value) {
                                          context.read<order_provider>().SetSelectionPayy(1);
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Row(
                                        children: [
                                          Icon(Icons.payment_outlined,color: Colors.orangeAccent,),
                                          SizedBox(width: 10,),
                                          Text("Ví VNPay"),
                                        ],
                                      ),
                                      value: value==2,
                                      onChanged: (bool? value) {
                                        context.read<order_provider>().SetSelectionPayy(2);
                                      },
                                    ),

                                  ],
                                );

                              }, selector: (BuildContext , order_provider ) {
                                return order_provider.SelectionPayy;

                            },)
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
                              Selector<order_provider,bool>(
                                builder: (BuildContext context, bool value, Widget? child) {
                                  return Text(
                                    "${tinhTienSauGiamGia(discountname, value, discountPrice)}VNĐ",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  );
                                }, selector: (BuildContext , order_provider ) {
                                  return order_provider.isLocationSelected;
                              },

                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              print("location: ${context.read<order_provider>().locationAddress}");
                              print("val_aduser: ${context.read<order_provider>().valAduser}");

                              final orderProvider = context.read<order_provider>();
                              List<detail> lstcopy = List<detail>.from(context.read<cart>().lst);

                              bool addressIsValid = false;
                              String deliveryAddress = "";

                              // Kiểm tra địa chỉ giao hàng
                              if (orderProvider.locationAddress.isNotEmpty &&
                                  !orderProvider.locationAddress.contains("null,null") &&
                                  !orderProvider.locationAddress.contains("null") &&
                                  orderProvider.locationAddress != "Lỗi khi lấy địa chỉ") {
                                addressIsValid = true;
                                deliveryAddress = orderProvider.locationAddress;
                              } else if (orderProvider.valAduser != null &&
                                  orderProvider.valAduser!.trim().isNotEmpty) {
                                addressIsValid = true;
                                deliveryAddress = orderProvider.valAduser!;
                              }
                              print(deliveryAddress);
                              if (!addressIsValid) {
                                showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    title: Text("Cảnh Báo"),
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 12, right: 12,top: 10,bottom: 10),
                                        child: Column(
                                          children: [
                                            Text("Có thể vị trí của bạn không được tìm thấy"),
                                            Text("Vui lòng nhập địa chỉ của bạn, để thuận tiện cho việc giao hàng"),
                                            SizedBox(height: 16),
                                            InkWell(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                decoration: BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "Đóng",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                                return;
                              }
                              if(context.read<order_provider>().selectedStore == null){

                                showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    title: Text("Cảnh Báo"),
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 12, right: 12,top: 10,bottom: 10),
                                        child: Column(
                                          children: [

                                            Text("Vui lòng chọn  địa chỉ đặt hàng, để thuận tiện cho việc giao hàng"),
                                            SizedBox(height: 16),
                                            InkWell(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                decoration: BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "Đóng",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );


                              }
                              dathang donHangMoi = dathang(
                                lat: context.read<order_provider>().userLocation!.latitude,
                                long: context.read<order_provider>().userLocation!.longitude,
                                lst: lstcopy,
                                ad_dat: orderProvider.selectedStore!,
                                ad_nhan: deliveryAddress,
                                nguoinhan: context.read<user_provider>().userinfo,
                                sdt:context.read<user_provider>().userinfo!.phoneNumber,
                                sl: context.read<cart>().tong,
                                gia: context.read<cart>().gia,
                                giamgia: orderProvider.discountPrice == 1
                                    ? 1
                                    : orderProvider.discountPrice * (context.read<cart>().tinhtien() as int).toDouble(),
                                phigiaohang: orderProvider.deliveryFee.round(),
                                trangthai: "Chờ Xác Nhận",
                                thanhtoan: context.read<order_provider>().SelectionPayy==1 ?"thanh toán khi nhận hàng" :"đã thanh toán",
                              );


                              if(context.read<order_provider>().SelectionPayy==2){

                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=>service_vnpay(
                                        amount:
                                        1000*double.parse("${tinhTienSauGiamGia(discountname, context.read<order_provider>().isLocationSelected, discountPrice) }") ))
                                );
                                print( "result: $result");

                                if (result != null) {
                                  if (result['status'] == 'success') {

                                    Provider.of<shipper>(context, listen: false).adddathang(donHangMoi);
                                    bool isSuccess = await Provider.of<shipper>(context, listen: false).saveOrderToFirebase(donHangMoi);

                                    if (isSuccess == true) {
                                      print("Thanh cong");
                                      context.read<cart>().clear();

                                      context.read<order_provider>().clearOrder();

                                      if (context.read<cart>().gia == 0) {
                                        Navigator.pop(context);
                                      }
                                      buildShowDialog(context, deliveryAddress, donHangMoi);
                                      

                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Thanh toán thành công: ${result['amount']}đ'))
                                    );



                                  } else if (result['status'] == 'error') {
                                    // Thanh toán thất bại
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Thanh toán thất bại: ${result['message']}'))
                                    );
                                  } else if (result['status'] == 'cancelled') {
                                    // Người dùng đã hủy thanh toán
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Đã hủy thanh toán'))
                                    );
                                  }
                                }

                                return;
                              }
                            else{
                              Provider.of<shipper>(context, listen: false).adddathang(donHangMoi);
                              bool isSuccess = await Provider.of<shipper>(context, listen: false).saveOrderToFirebase(donHangMoi);

                              if (isSuccess == true) {
                                print("Thanh cong");
                              }

                              context.read<cart>().clear();

                              context.read<order_provider>().clearOrder();

                              if (context.read<cart>().gia == 0) {
                                Navigator.pop(context);
                              }

                              buildShowDialog(context, deliveryAddress, donHangMoi);
                            }},
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "Đặt Hàng",
                                  style: TextStyle(fontSize: 16, color: Colors.orange),
                                ),
                              ),
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

  Future<dynamic> buildShowDialog(BuildContext context, String deliveryAddress, dathang donHangMoi) {
    return showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: Text("Thông Báo"),
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 12, right: 12),
                                    child: Column(
                                      children: [
                                        Text("Đơn hàng của bạn sẽ sớm được giao đến địa chỉ: "),
                                        SizedBox(height: 8),
                                        Text(
                                          deliveryAddress,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                decoration: BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "Xem chi tiết đơn hàng",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => thongtindonhang(don: donHangMoi)),
                                                );
                                              },
                                            ),
                                            InkWell(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "Đóng",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
  }




  // double _calculateDistance(double latTo,double longTo,double latFrom,double longFrom) {
  //
  //   double distanceInMeters = Geolocator.distanceBetween(latFrom, latFrom, longTo,longFrom );
  //   // return distanceInMeters / 1000; // Convert to kilometers
  // }




  DropdownMenuItem<String> buidMenu(String item) =>
      DropdownMenuItem(value: item, child: Text(item));


  String tinhTienSauGiamGia(String ma, bool isme , double discountPrice) {
    double tongTien = (context.read<cart>().tinhtien() as int).toDouble();
    double tienGiamGia = tongTien * discountPrice;
    double finalAmount = 0;

    if (ma == "" && isme == false) {
      finalAmount = tongTien + context.read<order_provider>().deliveryFee.round() ;
    } else if (ma != "" && isme == false) {
      finalAmount = tongTien + context.read<order_provider>().deliveryFee.round() - tienGiamGia;
    } else if (ma == "" && isme == true) {
      finalAmount = tongTien + context.read<order_provider>().deliveryFee.round() ;
    } else if (ma != "" && isme == true) {
    finalAmount = tongTien +  context.read<order_provider>().deliveryFee.round() - tienGiamGia;
    } else {
    finalAmount = tongTien ; // Trường hợp dự phòng
    }

    return formatCurrency(finalAmount);
  }
  String formatCurrency(double amount) {

    String formatted = amount.toStringAsFixed(3);
    return "$formatted ";
  }








}



