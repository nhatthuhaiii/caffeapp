

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';

import 'connectionDB.dart';

class Caffe {
  final String ma;
  final String ten;
  final String url;
  final int gia;
  final String mota;
  final bool isfv;

  Caffe({
    required this.ma,
    required this.ten,
    required this.url,
    required this.gia,
    required this.mota,
    required this.isfv,
  });

  static List<String> Listcategory() {
    List<String> lst = [];
    lst.add("nóng");
    lst.add("đá");
    lst.add("Cà Phê");
    lst.add("Trà");
    lst.add("Bánh");

    return lst;
  }
  Map<String, dynamic> toJson() {
    return {
      'ma': ma,
      'ten': ten,
      'url': url,
      'gia': gia,
      'mota': mota,
      'isfv': isfv,
    };
  }
  factory Caffe.fromJson(Map<String, dynamic> json) {
    return Caffe(
      ma: json['ma'] ?? '',  // Default to empty string if 'ma' is null
      ten: json['ten'] ?? '', // Default to empty string if 'ten' is null
      url: json['url'] ?? '', // Default to empty string if 'url' is null
      gia: json['gia'] ?? 0,  // Default to 0 if 'gia' is null
      mota: json['mota'] ?? '', // Default to empty string if 'mota' is null
      isfv: json['isfv'] ?? false, // Default to false if 'isfv' is null
    );
  }



}