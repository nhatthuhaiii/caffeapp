import 'package:cloud_firestore/cloud_firestore.dart';

class Discount {
  String name;
  double discountPrice;
  int count;

  Discount({
    required this.name,
    required this.discountPrice,
    required this.count
  });


  factory Discount.fromJson(Map<String, dynamic> json) {

    if (json['name'] == null) {
      throw FormatException('Name cannot be null');
    }

    return Discount(
        name: json['name'].toString(),

        discountPrice: json['discountPrice'] != null
            ? double.tryParse(json['discountPrice'].toString()) ?? 0.0
            : 0.0,

        count: json['count'] != null
            ? int.tryParse(json['count'].toString()) ?? 0
            : 0
    );
  }

  // Chuyển đổi đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'discountPrice': discountPrice,
      'count': count
    };
  }
  static Future<List<Discount>> getDiscounts() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await _firestore.collection('discount').get();

      List<Discount> discounts = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Discount.fromJson(data);
      }).toList();

      return discounts;
    } catch (e) {
      print('Lỗi khi lấy danh sách discount: $e');
      return [];
    }
  }
}
