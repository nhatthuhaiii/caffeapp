import 'dart:async';
import 'dart:convert';


import 'package:caffeapp/provider/getData.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../src/cuahang.dart';

class order_provider  extends ChangeNotifier{

  Position? userLocation;
  String? valAduser;
  double discountPrice = 1.0;
  double deliveryDistance = 0.0;
  double deliveryFee = 0.0;
  int SelectionPayy =1;


  String locationAddress = "";
  cuahang? selectedStore;
  bool isLocationSelected = false;
  Timer? debounceTimer;


  OrderProvider(BuildContext context) {
    selectedStore =context.read<getData>().listcuahang.first;
  }
  void setStore(cuahang store) {
    selectedStore = store;
    if (isLocationSelected && userLocation != null) {
      calculateDistanceFromCurrentLocation();
    } else if (valAduser != null && valAduser!.isNotEmpty) {
      getDistanceFromAddress(valAduser!);
    }
    notifyListeners();
  }

  void SetSelectionPayy(int value) {
    SelectionPayy = value;

    notifyListeners();

  }
  void useCurrentLocation() async {
    isLocationSelected = true;
    await getCurrentLocation();
    notifyListeners();
  }
  Future<void>  getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 4),
      );

      userLocation = position;
      print(userLocation);
      locationAddress = await getAddressFromLatLng(position);
      print(locationAddress);
      calculateDistanceFromCurrentLocation();
      notifyListeners();
    } catch (e) {
      print("Error getting location: $e");
    }
    notifyListeners();
  }
  void calculateDistanceFromCurrentLocation() {
    if (userLocation != null && selectedStore != null) {
      deliveryDistance = Geolocator.distanceBetween(
          userLocation!.latitude,
          userLocation!.longitude,
          selectedStore!.lattidude!,
          selectedStore!.longatitude!
      ) / 1000; // Convert to km

      deliveryFee = calculateFare(deliveryDistance);
      notifyListeners();
    }
  }
  void setAddress(String address) {
    valAduser = address;

    // Debounce to avoid too many API calls
    if (debounceTimer != null) debounceTimer!.cancel();
    debounceTimer = Timer(Duration(seconds: 2), () {
      getDistanceFromAddress(address);
    });
    notifyListeners();
  }
  Future<void> getDistanceFromAddress(String address) async {
    deliveryFee = 0;
    Position? position = await getLatLngFromGraphHopper(address);
    userLocation = position;
    print(position!);
  //  valAduser =  await getAddressFromLatLng(position!);
    if (position != null && selectedStore != null) {
      deliveryDistance = Geolocator.distanceBetween(
          selectedStore!.lattidude!,
          selectedStore!.longatitude!,
          position.latitude,
          position.longitude
      ) / 1000; // Convert to km

      deliveryFee = calculateFare(deliveryDistance);
      notifyListeners();
    }
  }
  void applyDiscount(String discountName, List<dynamic> availableDiscounts) {
    var matchingDiscounts = availableDiscounts.where(
            (discount) => discount.name == discountName
    );

    if (matchingDiscounts.isNotEmpty) {
      discountPrice = matchingDiscounts.first.discountPrice;
    } else {
      discountPrice = 1.0; // No discount
    }
    notifyListeners();
  }
  double calculateFinalPrice(double subtotal) {
    double discountAmount = subtotal * (1 - discountPrice);
    notifyListeners();
    return subtotal - discountAmount + deliveryFee.round();

  }
  double calculateFare(double distance) {
    const double baseFare = 10;
    const double farePerKm = 3;
    const double firstKm = 1.0;

    if (distance <= 0) return 0;

    if (distance <= firstKm) {
      return baseFare;
    } else {
      return baseFare + (distance - firstKm) * farePerKm;
    }
    notifyListeners();
  }
  Future<Position?> getLatLngFromGraphHopper(String address) async {
    String apiKey = "ec614973-73ab-42f6-8fe4-a5ba3c05cb39";

    String url = "https://graphhopper.com/api/1/geocode?q=${Uri.encodeComponent(address)}&locale=vi&limit=1&key=$apiKey";

    try {

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["hits"].isNotEmpty) {
          var location = data["hits"][0]["point"];
          notifyListeners();
          return Position(
            latitude: location["lat"],
            longitude: location["lng"],
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0,
          );
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<String> getAddressFromLatLng(Position position) async {
    final url = Uri.parse(
          "https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&addressdetails=1");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Lấy display_name từ kết quả trả về
        String displayName = data["display_name"];

        // Xóa các thông tin không mong muốn
        displayName = displayName
            .replaceAll("Street", "")
            .replaceAll("District", "")
            .replaceAll("54000", "")
            .replaceAll("Vietnam", "")
            .replaceAll(", ,", ",") // Xóa dấu phẩy kép
            .replaceAll(RegExp(r',\s*$'), "") // Xóa dấu phẩy cuối cùng
            .replaceAll(RegExp(r'\s{2,}'), " ") // Xóa khoảng trắng dư thừa
            .trim();

        print("Đã chỉnh sửa: $displayName");

        notifyListeners();
        return displayName;
      } else {
        return "Không thể lấy địa chỉ: ${response.statusCode}";
      }
    } catch (e) {
      return "Lỗi khi lấy địa chỉ: $e";
    }
  }
  void clearOrder() {
    SelectionPayy=1;
    locationAddress= "";
    isLocationSelected = false;
    selectedStore = null;
    deliveryFee = 0.0;
    deliveryDistance = 0.0;
    discountPrice = 1.0;
    userLocation=null;
    valAduser=null;
    debounceTimer=null;
    notifyListeners();
  }



}