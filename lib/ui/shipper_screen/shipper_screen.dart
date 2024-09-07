import 'dart:async';
import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/provider/shipper_provider.dart';
import 'package:caffeapp/ui/cafeapp.dart';
import 'package:caffeapp/ui/shipper_screen/detail_shipper_screen/detail_screen_shipper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../src/dathang.dart';

class screen_shipper extends StatefulWidget {
  const screen_shipper({Key? key}) : super(key: key);

  @override
  State<screen_shipper> createState() => _ScreenShipperState();
}

class _ScreenShipperState extends State<screen_shipper> {
  LatLng? currentLocation;
  StreamSubscription<QuerySnapshot>? orderSubscription;
  Set<String> displayedOrders = {};
  dathang? _currentOrder;
  final double maxDistance = 10000; // 10km
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    orderSubscription?.cancel();
    context.read<shipper_provider>().clearShipper();
    super.dispose();
  }

  Future<void> _initialize() async {
    await _getCurrentLocation();
    _listenToUnconfirmedOrders();
  }

  Future<void> _getCurrentLocation() async {


    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        currentLocation = LatLng(pos.latitude, pos.longitude);
      });
    }
  }

  double calculateDistance(LatLng a, LatLng b) {
    return Distance().call(a, b);
  }

  void _listenToUnconfirmedOrders() {
    orderSubscription = FirebaseFirestore.instance
        .collection('orderdetail')
        .where('trangthai', isEqualTo: 'đã xác nhận')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
        if (displayedOrders.contains(doc.id)) continue;

        final data = doc.data() as Map<String, dynamic>;
        final order = dathang.fromJson(data);
        final shipperInfo = context.read<shipper_provider>().info;

        if (shipperInfo?.status == true && currentLocation != null) {
          final toLatLng = LatLng(order.lat!, order.long!);
          final fromLatLng = LatLng(order.ad_dat!.lattidude!, order.ad_dat!.longatitude!);
          final distTo = calculateDistance(currentLocation!, toLatLng);
          final distFrom = calculateDistance(currentLocation!, fromLatLng);

          if (distTo <= maxDistance && distFrom <= maxDistance) {
            displayedOrders.add(doc.id);
            setState(() {
              _currentOrder = order;
              print(_currentOrder!.id);
            });
            Future.delayed(Duration.zero, _showOrderDialog);
            break;
          }
        }
      }
    });
  }

  void _showOrderDialog() {
    if (_dialogShown || _currentOrder == null) return;
    _dialogShown = true;

    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Đơn hàng mới'),
        content: SizedBox(
          width: 300,
          height: 100,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Địa chỉ giao: ${_currentOrder!.ad_nhan}'),
                const SizedBox(height: 8),
                Text('Địa chỉ lấy hàng: ${_currentOrder!.ad_dat!.diachi}'),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              final id = _currentOrder!.id!;

              _acceptOrder(_currentOrder!.id!);
              context.read<shipper_provider>().getOrderById(id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => detail_screen_shipper(don: id,),
                ),
              );
              setState(() {
                _currentOrder = null;
                _dialogShown = false;
              });
            },
            child: const Text('Xác nhận',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );

  }

  void _acceptOrder(String orderId) async {
    final shipper = context.read<shipper_provider>().info;
    if (shipper == null || currentLocation == null) return;

    shipper.lat = currentLocation!.latitude;
    shipper.long = currentLocation!.longitude;
    context.read<shipper_provider>().setStatus(false);

    final infoMap = shipper.toJson();

    try {
      await FirebaseFirestore.instance
          .collection('orderdetail')
          .doc(orderId)
          .update({'trangthai': 'vận chuyển', 'shipper': infoMap});
      // await FirebaseFirestore.instance
      //     .collection('shipper')
      //     .doc(orderId)
      //     .update({'status': 'false'});



      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã nhận đơn hàng thành công')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                    Text("Giao hàng",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          context.read<shipper_provider>().clearShipper();
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>caffeapp(currentPage: NavigationPages.home)));
                        },
                        child: Icon(Icons.logout),
                      )
      
                  ],),
                ),
                Expanded(
                  child: FlutterMap(
                          options: MapOptions(initialCenter: currentLocation!, initialZoom: 16),
                          children: [
                  TileLayer(
                    urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: currentLocation!,
                        width: 60,
                        height: 60,
                        child: const Icon(Icons.my_location, size: 40, color: Colors.blue),
                      ),
                    ],
                  ),
                          ],
                        ),
                ),
              ],
            ),
      ),
    );
  }
}
