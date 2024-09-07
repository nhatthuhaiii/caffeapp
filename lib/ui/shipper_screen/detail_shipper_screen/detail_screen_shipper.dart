import 'dart:async';
import 'dart:convert';
import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/provider/shipper_provider.dart';
import 'package:caffeapp/ui/admin_screen/admin_function/firebase_Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../src/dathang.dart';
import '../../../src/detail.dart';
import '../shipper_screen.dart';

class detail_screen_shipper extends StatefulWidget {
  detail_screen_shipper({super.key, required this.don});
  final String? don;

  @override
  State<detail_screen_shipper> createState() => _detail_screen_shipperState();
}

class _detail_screen_shipperState extends State<detail_screen_shipper> {
  dathang? order;
  List<LatLng> route = [];
  List<LatLng> routeShop=[];
  bool isLoading = true;
  bool _routeFetched = false;
  final MapController _mapController = MapController();

  StreamSubscription<Position>? _positionStream;
  LatLng? _shipperLocation;

  @override
  void initState() {
    super.initState();
    _loadOrder();
    _startLocationStream();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  Future<void> _loadOrder() async {
    final result =
    await context.read<shipper_provider>().getOrderById(widget.don!);
    if (result != null) {
      setState(() {
        order = result;
      });
     route =  await _fetchRoute(
        result.lat!,
        result.long!,
        result.ad_dat!.lattidude!,
        result.ad_dat!.longatitude!,
      );
     routeShop =await _fetchRoute(_shipperLocation!.latitude, _shipperLocation!.longitude,
         order!.ad_dat!.lattidude!,
         order!.ad_dat!.longatitude!);

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<LatLng>> _fetchRoute(
      double startLat, double startLng, double endLat, double endLng) async {
    String apiKey = "21c16184-32de-4f65-aa74-332f0ffd6574";
    String url =
        "https://graphhopper.com/api/1/route?point=$startLat,$startLng&point=$endLat,$endLng&vehicle=car&key=$apiKey&points_encoded=false";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coords = data['paths'][0]['points']['coordinates'];
      List<LatLng> temp = [];
      setState(() {
        temp = coords.
            map((coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
            .toList();
      });
      return temp;
    }
    return [];
  }

  void _startLocationStream() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) return;

    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      setState(() {
        _shipperLocation = LatLng(position.latitude, position.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || order == null || _shipperLocation == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Đang tải..."), backgroundColor: Colors.orangeAccent),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final dathang value = order!;

    return Scaffold(
      appBar: AppBar(title: Text("Chi tiết đơn hàng"), backgroundColor: Colors.orangeAccent),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_shipperLocation != null) {
            _mapController.move(_shipperLocation!, 17);
          }
        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.my_location),
      ),

      body: Container(
        margin: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Thời gian
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      "Thời gian đặt hàng: ${value.times!.hour}:${value.times!.minute} ${value.times!.day}/${value.times!.month}/${value.times!.year}")),
              Divider(),

              // Thông tin điểm đến
              Row(children: [Icon(Icons.store, color: Colors.red), SizedBox(width: 5), Text("Từ")]),
             Align(
               alignment: Alignment.topLeft,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 Text("Coffe Home", style: TextStyle(fontWeight: FontWeight.bold)),
                 Text("${value.ad_dat!.diachi}", style: TextStyle(fontWeight: FontWeight.bold)),
               ],),
             ),
              Divider(),

              // Thông tin người nhận
              Row(children: [Icon(Icons.location_on, color: Colors.green), SizedBox(width: 5), Text("Đến")]),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${value.ad_nhan}", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Tên: ${value.nguoinhan!.name}"),
                    Text("Điện thoại: ${value.nguoinhan!.phoneNumber}"),
                  ],
                ),
              ),
              Divider(),

              // Bản đồ
              Container(
                height: 450,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(initialCenter: _shipperLocation!, initialZoom: 15),
                  children: [
                    TileLayer(
                      urlTemplate:
                      "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(points: route, strokeWidth: 3.0, color: Colors.blue),
                        Polyline(points: routeShop,strokeWidth: 3.0,color: Colors.red),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _shipperLocation!,
                          width: 40,
                          height: 40,
                          child: Icon(Icons.location_on, color: Colors.red),
                        ),
                        Marker(
                          point: LatLng(value.lat!, value.long!),
                          width: 40,
                          height: 40,
                          child: Icon(Icons.home, color: Colors.green),
                        ),
                        Marker(
                          point: LatLng(value.ad_dat!.lattidude!, value.ad_dat!.longatitude!),
                          width: 40,
                          height: 40,
                          child: Icon(Icons.store, color: Colors.orange),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),

              // Button chi tiết
              ElevatedButton(
                onPressed: () => _showOrderDetail(value),
                child: Text("Chi tiết đơn hàng",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderDetail(dathang value) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        height: 400,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text("Chi tiết đơn hàng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
            ...value.lst.map((detail d) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${d.a.ten} ${d.size} x${d.sl}"),
                Text("${d.a.gia}.000VNĐ"),
              ],
            )),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Giá sản phẩm:"),
              Text("${value.gia}.000VNĐ"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Giảm giá:"),
              Text("${value.giamgia == 1 ? "0VNĐ" : formatCurrency(value.giamgia!)}"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Phí giao hàng:"),
              Text("${value.phigiaohang}.000VNĐ"),
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Thu của khách:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                value.giamgia == 1
                    ? "${value.gia! + value.phigiaohang!}.000VNĐ"
                    : "${value.gia! + value.phigiaohang! - value.giamgia!}.000VNĐ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ]),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('orderdetail')
                    .doc(value.id)
                    .update({'trangthai': "giao hàng thành công", 'thanhtoan': "đã thanh toán"});


                context.read<shipper_provider>().setStatus(true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => screen_shipper()),
                );
              },
              child: Text("Xác nhận đã giao hàng",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        ),
      ),
    );
  }

  String formatCurrency(double amount) {
    return "${amount.toStringAsFixed(3)} VND";
  }
}
