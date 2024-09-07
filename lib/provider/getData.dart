import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../src/Discount.dart';
import '../src/cafe.dart';
import '../src/cuahang.dart';
import '../src/dathang.dart';

class getData extends ChangeNotifier {
  List<Caffe> listcaffe = [];
  List<dathang> listdonhang = [];
  List<cuahang> listcuahang = [];
  List<Discount> listdiscount = [];
  late Caffe item;

  StreamSubscription? _caffeSubscription;
  StreamSubscription? _storeSubscription;
  StreamSubscription? _orderSubscription;
  StreamSubscription? _discountSubscription;

  // Khởi tạo tất cả streams
  void initStreams() {
    getListStream();
    getCuaHangListStream();
    getOrdersStream();
    getDiscountList();
  }


  void getListStream() {
    // Hủy subscription cũ nếu có
    _caffeSubscription?.cancel();

    // Lắng nghe collection "caffe"
    _caffeSubscription = FirebaseFirestore.instance
        .collection('caffe')
        .snapshots()
        .listen((snapshot) {
      List<Caffe> lst = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        item = Caffe(
            ma: data["ma"],
            ten: data["ten"],
            url: data["url"],
            gia: data["gia"],
            mota: data["mota"],
            isfv: data["isfv"]
        );
        lst.add(item);
      }

      listcaffe = lst;
      notifyListeners();
    }, onError: (error) {
      print("Lỗi khi lắng nghe dữ liệu caffe: $error");
    });
  }

  // Phương thức lắng nghe dữ liệu cửa hàng theo thời gian thực
  void getCuaHangListStream() {
    // Hủy subscription cũ nếu có
    _storeSubscription?.cancel();

    // Lắng nghe collection "store"
    _storeSubscription = FirebaseFirestore.instance
        .collection('store')
        .snapshots()
        .listen((snapshot) {
      List<cuahang> lst = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        var item = cuahang(
            id: data["id"],
            lattidude: data["latitude"],
            longatitude: data["longitude"],
            diachi: data["diachi"],
            url: data["url"],
            qc1: data["qc1"],
            qc2: data["qc2"],
            qc3: data["qc3"]
        );
        lst.add(item);
      }

      listcuahang = lst;
      print("Số lượng cửa hàng cập nhật: ${listcuahang.length}");
      notifyListeners();
    }, onError: (error) {
      print("Lỗi khi lắng nghe dữ liệu cửa hàng: $error");
    });
  }

  // Phương thức lắng nghe dữ liệu đơn hàng theo thời gian thực
  void getOrdersStream() {
    // Hủy subscription cũ nếu có
    _orderSubscription?.cancel();

    // Lắng nghe collection "orderdetail" với sắp xếp theo timestamp
    _orderSubscription = FirebaseFirestore.instance
        .collection('orderdetail')
        .orderBy('timestamp', descending: true)
        .limit(5)
        .snapshots()
        .listen((snapshot) {
      List<dathang> recentOrderList = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return dathang.fromJson(data);
      }).toList();

      listdonhang = recentOrderList;
      print('Số lượng đơn hàng cập nhật: ${listdonhang.length}');
      notifyListeners();
    }, onError: (error) {
      print("Lỗi khi lắng nghe dữ liệu đơn hàng: $error");
      listdonhang = [];
      notifyListeners();
    });
  }








  Future<void> getList() async {
    List<Caffe> lst = [];

    var collection = FirebaseFirestore.instance.collection('caffe');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<dynamic, dynamic> data = queryDocumentSnapshot.data();
      item = Caffe(ma: data["ma"],
          ten: data["ten"],
          url: data["url"],
          gia: data["gia"],
          mota: data["mota"],
          isfv: data["isfv"]);
      lst.add(item);
    }

    listcaffe = lst;

    // QuerySnapshot querySnapshot = await FirebaseFirestore.
    // instance.collection("caffe").get(
    // for (var element in querySnapshot.docs) {
    //   Map<String, dynamic> data = element.data();
    //   item = Caffe(element.data()!["ma"], ten, url, gia, mota, isfv)


    notifyListeners();
  }

  get throwList {
    return listcaffe;
  }

  Future<void> getCuaHangListFromFirestore() async {
    try {
      var collection = FirebaseFirestore.instance.collection('store');
      var querySnapshot = await collection.get();
      List<cuahang> lst = []; // Lấy tất cả tài liệu trong collection
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<dynamic, dynamic> data = queryDocumentSnapshot.data();
        var item = cuahang(
            id: data["id"],
            lattidude: data["latitude"],
            longatitude: data["longitude"],
            diachi: data["diachi"],
            url: data["url"],
            qc1: data["qc1"],
            qc2: data["qc2"],
            qc3: data["qc3"]);
        lst.add(item);
      }
      listcuahang = lst;
      notifyListeners();
      print("Số lượng cửa hàng lấy được: ${listcuahang.length}");
    } catch (e) {
      print("Lỗi khi lấy danh sách cửa hàng: $e");
    }
  }


  Future<void> getOrders() async {
    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orderdetail')
          .orderBy('timestamp', descending: true)
          .limit(30)
          .get();


      List<dathang> recentOrderList = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return dathang.fromJson(data);
      }).toList();

      listdonhang = recentOrderList;
      print('Số lượng đơn hàng gần đây tìm được: ${listdonhang.length}');

      notifyListeners(); // Thông báo thay đổi dữ liệu
    } catch (e) {
      print("Lỗi khi lấy đơn hàng: $e");
      listdonhang = [];
    }
  }

  void clearData()
  {

    listdonhang = [];
    //listcuahang = [];
    notifyListeners();
    }
  void getDiscountListStream() {
    // Hủy subscription cũ nếu có
    _discountSubscription?.cancel();

    _discountSubscription = FirebaseFirestore.instance
        .collection('discount')
        .snapshots()
        .listen((snapshot) {
      List<Discount> lst = [];

      for (var doc in snapshot.docs) {
        try {
          Map<String, dynamic> data = doc.data();
          var item = Discount.fromJson(data);
          lst.add(item);
        } catch (e) {
          print('Lỗi khi phân tích discount: $e');
        }
      }

      listdiscount = lst;
      print('Số lượng mã giảm giá cập nhật: ${listdiscount.length}');
      notifyListeners();
    }, onError: (error) {
      print("Lỗi khi lắng nghe dữ liệu discount: $error");
    });
  }
  Future<void> getDiscountList() async {
    try {
      var collection = FirebaseFirestore.instance.collection('discount');
      var querySnapshot = await collection.get();

      List<Discount> lst = [];

      for (var doc in querySnapshot.docs) {
        try {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          var item = Discount.fromJson(data);
          lst.add(item);
        } catch (e) {
          print('Lỗi khi phân tích dữ liệu discount: $e');
        }
      }

      listdiscount = lst;
      print('Số lượng mã giảm giá lấy được: ${listdiscount.length}');
      notifyListeners();
    } catch (e) {
      print("Lỗi khi lấy danh sách discount: $e");
      listdiscount = [];
    }
  }

}


