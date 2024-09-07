import 'package:caffeapp/ui/admin_screen/admin_function/firebase_Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/getData.dart';
import '../../../src/dathang.dart';
import '../../main_screen/Screen_Notifi/Screen_orderDetail/thongtindonhang.dart';

class admin_orderDetail_screen extends StatefulWidget {
  const admin_orderDetail_screen({super.key});

  @override
  State<admin_orderDetail_screen> createState() =>
      _admin_orderDetail_screenState();
}

class _admin_orderDetail_screenState extends State<admin_orderDetail_screen> {
  List<dathang> lst = [];
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    //context.read<getData>().getOrders();
    lst = context.read<getData>().listdonhang;
    lst.sort((a, b) =>
        b.times!.toLocal().day.compareTo(a.times!.toLocal().day));


  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentPage = page;
    });
  }

  Widget _buildOrderList(List<dathang> lst ,bool isConfirmed ,IconData icon) {
    // Lọc danh sách trực tiếp dựa trên tham số isConfirmed
    final filteredOrders = lst.where((order) {
      if (isConfirmed) {

        return order.trangthai!.toLowerCase() == "đã xác nhận";
      } else {

        return order.trangthai == null || order.trangthai!.toLowerCase() == "chờ xác nhận";
      }
    }).toList();

    return filteredOrders.isEmpty
        ? const Center(
      child: Text(
        "Không có đơn hàng nào",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    )
        : ListView.builder(
      itemCount: filteredOrders.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final x = filteredOrders[index]; // Lấy đơn hàng hiện tại

        return InkWell(
          onTap: () {
            // Xử lý khi nhấp vào đơn hàng
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => thongtindonhang(don: x),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 5),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/caphe_dennong.jpg", height: 70, width: 70),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Trạng thái: ${x.trangthai} "),
                      Text("Vị trí đặt hàng: ${x.ad_nhan}"),
                      Text("Thời gian đặt hàng: ${x.getFormattedTime()}"),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    ElevatedButton(
                    onPressed: () {

                            firebase_Utils.updateTrangThaiDonHang(x.id!);




                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                          child: const Text("Xác nhận",style: TextStyle(color: Colors.white),),
                        ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        firebase_Utils.deleteDonHang(x.id!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      child: const Text("Xoá",style: TextStyle(color: Colors.white),),
                    ),


                  ],
                ),
              ],
            ),
          )
          ,
        );
      },
    );
  }
  Widget _buildDoneOrdersList(List<dathang> orders, IconData icon) {
    final shippingOrders = orders.where((order) {
      final status = order.trangthai?.toLowerCase();
      return   status == "giao hàng thành công";
    }).toList();

    if (shippingOrders.isEmpty) {
      return const Center(
        child: Text(
          "Không có đơn hàng đang vận chuyển",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: shippingOrders.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final x = shippingOrders[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => thongtindonhang(don: x),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Image.asset("images/caphe_dennong.jpg", height: 70, width: 70),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Trạng thái: ${x.trangthai}"),
                      Text("Vị trí đặt hàng: ${x.ad_nhan}"),
                      Text("Thời gian đặt hàng: ${x.getFormattedTime()}"),
                    ],
                  ),
                ),
                Icon(icon, color: Colors.orangeAccent, size: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShippingOrdersList(List<dathang> orders, IconData icon) {
    final shippingOrders = orders.where((order) {
      final status = order.trangthai?.toLowerCase();
      return status == "vận chuyển"  ;
    }).toList();

    if (shippingOrders.isEmpty) {
      return const Center(
        child: Text(
          "Không có đơn hàng đang vận chuyển",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: shippingOrders.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final x = shippingOrders[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => thongtindonhang(don: x),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Image.asset("images/caphe_dennong.jpg", height: 70, width: 70),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Trạng thái: ${x.trangthai}"),
                      Text("Vị trí đặt hàng: ${x.ad_nhan}"),
                      Text("Thời gian đặt hàng: ${x.getFormattedTime()}"),
                    ],
                  ),
                ),
                Icon(icon, color: Colors.orangeAccent, size: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget  _buildOrderListConfimer(List<dathang> lst ,bool isConfirmed ,IconData icon) {
    // Lọc danh sách trực tiếp dựa trên tham số isConfirmed
    final filteredOrders = lst.where((order) {
      if (isConfirmed) {

        return order.trangthai!.toLowerCase() == "đã xác nhận";
      } else {

        return order.trangthai == null || order.trangthai!.toLowerCase() == "chờ xác nhận";
      }
    }).toList();

    return filteredOrders.isEmpty
        ? const Center(
      child: Text(
        "Không có đơn hàng nào",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    )
        : ListView.builder(
      itemCount: filteredOrders.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final x = filteredOrders[index]; // Lấy đơn hàng hiện tại

        return InkWell(
          onTap: () {
            // Xử lý khi nhấp vào đơn hàng
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => thongtindonhang(don: x),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Image.asset("images/caphe_dennong.jpg", height: 70, width: 70),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Trạng thái: ${x.trangthai} "),
                      Text("vị trí đặt hàng ${x.ad_nhan}"),
                      Text("Thời gian đặt hàng: ${x.getFormattedTime()}"),
                    ],
                  ),
                ),
                Container(
                  child: Icon(icon as IconData? , color: Colors.orangeAccent, size: 30,),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Đơn Hàng",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),


                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          _changePage(0);
                        },
                        child: Container(
                          height: 50,
                          child: Center(child: Text("Chưa xác nhận")),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            color: Colors.orangeAccent
                          )
                          ,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          _changePage(1);
                        },
                        child: Container(
                          height: 50,
                          child: Center(child: Text("đã xác nhận")),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                              color: Colors.orangeAccent
                          )
                          ,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          _changePage(2);
                        },
                        child: Container(
                          height: 50,
                          child: Center(child: Text("vận chuyển")),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                              color: Colors.orangeAccent
                          )
                          ,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          _changePage(3);
                        },
                        child: Container(
                          height: 50,
                          child: Center(child: Text("hoàn thành")),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                              color: Colors.orangeAccent
                          )
                          ,
                        ),
                      ),
                    )


                  ]),
                // lst.isEmpty
                //     ? const CircularProgressIndicator()
                //     :
                Expanded(
                      child: Selector<getData,List<dathang>>(
                        builder: (BuildContext context, List<dathang> value, Widget? child) {

                          return PageView(
                            controller: _pageController,

                            children: [
                              _buildOrderList(value,false,Icons.save_outlined),

                              _buildOrderListConfimer(value,true ,Icons.done_outlined),

                              _buildShippingOrdersList(value,Icons.delivery_dining_outlined) ,
                              _buildDoneOrdersList(value,Icons.done_all_outlined)
                            ],
                          );
                        },

                        selector: (BuildContext , getData ) {

                          return getData.listdonhang;

                        },

                      ),
                    )

              ],
            ),
          ),
        ));
  }
}


