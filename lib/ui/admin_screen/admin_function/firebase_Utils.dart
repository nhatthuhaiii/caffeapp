import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../src/cafe.dart';
import '../../../src/cuahang.dart';

class firebase_Utils extends ChangeNotifier{
  cuahang? _store;
  cuahang? get store => _store;
  Caffe? _product;
  Caffe? get product => _product;


  void setStore(cuahang store) {
    _store = store;
    notifyListeners();
  }
  void clearStore() {
    _store = null;
    notifyListeners();
  }
  void setProduct(Caffe product) {
    _product = product;
    notifyListeners();
  }
  void clearProduct() {
    _product = null;
    notifyListeners();
  }


  // thêm cửa hàng mới
 static Future<void> addStore(cuahang store) async {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      await _firestore.collection('store').add({
        'id': store.id,
        'latitude': store.lattidude,
        'longitude': store.longatitude,
        'diachi': store.diachi,
        'url': store.url,
        'qc1': store.qc1,
        'qc2': store.qc2,
        'qc3': store.qc3,
      });
      print("Đã thêm cửa hàng thành công!");
    } catch (e) {
      print("Lỗi khi thêm cửa hàng: $e");
      throw e;
    }
  }



  // cập nhật cửa hàng theo id
  static Future<void> updateStoreByFieldId({
    required String fieldId,
    required Map<String, dynamic> updatedData,
  }) async {
    try {


      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('store')
          .where('id', isEqualTo: fieldId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {

        String docId = querySnapshot.docs.first.id;


        await FirebaseFirestore.instance
            .collection('store')
            .doc(docId)
            .update(updatedData);

        print("Dữ liệu đã được cập nhật thành công!");
      } else {
        print("Không tìm thấy cửa hàng có id = $fieldId.");
      }


    } catch (e) {
      print("Lỗi khi cập nhật dữ liệu: $e");
      rethrow;
    }
  }

  static Future<void> addCaffe(Caffe caffe) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      await _firestore.collection('caffe').add({
        'ma': caffe.ma,
        'gia': caffe.gia,
        'ten': caffe.ten,
        'url': caffe.url,
        'isfv':caffe.isfv,
        'mota': caffe.mota

      });
    }
    catch (e) {
      print("Lỗi khi thêm sản phẩm: $e");
      throw e;
    }
  }
  static Future<void> addDiscount(String name, double price, int count) async {
    if (name.isNotEmpty && price > 0) {
      try {
        await FirebaseFirestore.instance.collection('discount').add({
          'name': name,
          'discountPrice': price,
          'count': count,
        });
      } catch (e) {
        // Xử lý lỗi nếu cần
        print('Lỗi khi thêm mã giảm giá: $e');
      }
    }
  }
  static Future<void> deleteDiscountByName(String name) async {
    try {
      // Truy vấn để tìm tài liệu có trường 'name' khớp với giá trị
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('discount')
          .where('name', isEqualTo: name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Duyệt qua tất cả các tài liệu và xóa chúng
        for (final doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        print('Mã giảm giá "$name" đã được xóa thành công.');
      } else {
        print('Không tìm thấy mã giảm giá với tên "$name".');
      }
    } catch (e) {
      print('Có lỗi xảy ra khi xóa mã giảm giá: $e');
    }
  }




  static Future<void> deleteDonHang(String id) async {
    try {
      // Truy cập đến collection orderdetail và document có id tương ứng
      DocumentReference orderRef =
      FirebaseFirestore.instance.collection('orderdetail').doc(id);

      // Cập nhật trường thanhtoan
      await orderRef.update({
        'trangthai':" bị huỷ",
      });

      print('Cập nhật trạng thái thành công');

    } catch (e) {
      print('Lỗi khi cập nhật trạng thái đơn hàng: $e');

    }
  }

  static Future<bool> updateTrangThaiDonHang(String idDonHang) async {
    try {

      DocumentReference orderRef =
      FirebaseFirestore.instance.collection('orderdetail').doc(idDonHang);


      await orderRef.update({
        'trangthai':"đã xác nhận",
      });

      print('Cập nhật trạng thái thành công');
      return true;
    } catch (e) {
      print('Lỗi khi cập nhật trạng thái đơn hàng: $e');
      return false;
    }
  }

  static Future<void> deleteStoreByFieldId(String id) async {
    try {
      // Truy vấn để tìm tài liệu có trường 'id' khớp với giá trị
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('store')
          .where('id', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;


        // Xóa tài liệu dựa trên ID
        await FirebaseFirestore.instance.collection('store').doc(docId).delete();

        print('Store với id "$id" đã được xóa thành công.');
      } else {
        print('Không tìm thấy store có id "$id".');
      }
    } catch (e) {
      print('Có lỗi xảy ra khi xóa store: $e');
    }
  }




  static Future<void> deleteProductByFieldMa(String ma) async {
    try {
      // Truy vấn để tìm tài liệu có trường "ma" khớp với giá trị
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('caffe')
          .where('ma', isEqualTo: ma)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;

        // Xóa tài liệu dựa trên ID
        await FirebaseFirestore.instance.collection('caffe').doc(docId).delete();

        print('Sản phẩm với mã "$ma" đã được xóa thành công.');
      } else {
        print('Không tìm thấy sản phẩm có mã "$ma".');
      }
    } catch (e) {
      print('Có lỗi xảy ra: $e');
    }
  }





  static Future<void> updateCaffeByFieldId({
    required String fieldId,
    required Map<String, dynamic> updatedData,
  }) async {
    try {


      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('caffe')
          .where('ma', isEqualTo: fieldId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {

        String docId = querySnapshot.docs.first.id;


        await FirebaseFirestore.instance
            .collection('caffe')
            .doc(docId)
            .update(updatedData);

        print("Dữ liệu đã được cập nhật thành công!");
      } else {
        print("Không tìm thấy sản phẩm có ma = $fieldId.");
      }


    } catch (e) {
      print("Lỗi khi cập nhật dữ liệu: $e");
      rethrow;
    }
  }











}

