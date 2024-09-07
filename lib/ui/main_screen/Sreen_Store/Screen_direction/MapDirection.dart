import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../../../../src/cuahang.dart';

class MapDirection extends StatefulWidget {
  const MapDirection({super.key, required this.item});
  final cuahang? item;

  @override
  State<MapDirection> createState() => _MapDirectionState();
}

class _MapDirectionState extends State<MapDirection> {
  Position? userLocation;
  List<LatLng> coordinates = [];
  bool isLoading = true;
  double inzoom = 6.8;
  double lat = 0.0;
  double long = 0.0;
  bool isRouteActive = false;
  final MapController _mapController = MapController();
  late StreamSubscription<Position> positionStream;
  bool isZoomActive = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    try {
      // Request location permission
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get route
      await _getRoute(position);
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void activeRoute() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        widget.item!.lattidude!,
        widget.item!.longatitude!,
      );
      if (distance <= 1.0) {
        positionStream.cancel();
        SnackBar item = const SnackBar(content: Text("Đã đến vị trí quán"));
        ScaffoldMessenger.of(context).showSnackBar(item);
        return;
      }
      // Gọi hàm lấy route mới nếu cần
      _getRoute(position);
    });
  }

  Future<void> _getRoute(Position position) async {
    try {
      final String key =
          'https://graphhopper.com/api/1/route?point=${position.latitude},${position.longitude}&point=${widget.item!.lattidude!},${widget.item!.longatitude!}&vehicle=car&key=ec614973-73ab-42f6-8fe4-a5ba3c05cb39&points_encoded=false';

      final response = await http.get(Uri.parse(key));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> lst = data['paths'][0]['points']['coordinates'];

        setState(() {
          userLocation = position;
          coordinates = lst.map((coord) => LatLng(coord[1], coord[0])).toList();
          lat = (userLocation!.latitude + widget.item!.lattidude!) / 2;
          long = (userLocation!.longitude + widget.item!.longatitude!) / 2;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error getting route: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child:  Icon(
            isZoomActive ? Icons.close : Icons.near_me, color: Colors.white),
        onPressed: () {
          setState(() {
            if (userLocation == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Không thể xác định vị trí hiện tại")));
              return;
            }


            if (isZoomActive) {

              _mapController.move(
                LatLng(lat, long),
                inzoom,
              );
            } else {
              // Kích hoạt chế độ zoom
              _mapController.move(
                LatLng(userLocation!.latitude, userLocation!.longitude),
                16.0, // Mức zoom cao hơn
              );
              activeRoute();
            }

            // Thay đổi trạng thái
            isZoomActive = !isZoomActive;
          });
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Đường đi từ vị trí của bạn"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userLocation == null
          ? const Center(child: Text("Không thể lấy vị trí"))
          : FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(
            lat,
            long,
          ),
          initialZoom: inzoom,
        ),
        children: [
          TileLayer(
            urlTemplate:
            "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: [
            Marker(
                point: LatLng(
                    widget.item!.lattidude!, widget.item!.longatitude!),
                child: const Icon(Icons.coffee,
                    color: Colors.orangeAccent)),
            Marker(
                point: LatLng(
                    userLocation!.latitude, userLocation!.longitude),
                child: const Icon(Icons.location_on,
                    color: Colors.blue))
          ]),
          coordinates.isNotEmpty
              ? PolylineLayer(
            polylines: [
              Polyline(
                  points: coordinates,
                  color: Colors.red,
                  strokeWidth: 3)
            ],
          )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
