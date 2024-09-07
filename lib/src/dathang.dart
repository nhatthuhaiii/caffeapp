import 'package:caffeapp/src/shipper.dart';
import 'package:caffeapp/src/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'cuahang.dart';
import 'detail.dart';

class dathang{
   List<detail> lst;
   user? nguoinhan;
   String? sdt;
   int? sl;
   int? gia;
   double? giamgia;
   Position? pos_nhan;
   Position? pos_dat;
   int ? phigiaohang;
   String? ad_nhan;
   cuahang? ad_dat;
   String? thanhtoan;
   DateTime? times;
   double? lat;
   double? long;
   String? id;
   String? trangthai;
   shippeUser? shipper;
   dathang({
     required this.lst,
     required this.ad_dat,
     required this.ad_nhan,
     required this.nguoinhan,
     required this.sdt,
     required this.sl,
     required this.gia,
     required this.giamgia,
     required this.phigiaohang, this.times,this.thanhtoan,this.lat,this.long,this.id,this.trangthai,this.shipper

   }) {
      // Gán thời gian hiện tại
   }
   factory dathang.fromJson(Map<String, dynamic> json) {
     return dathang(
       id: (json['id']),
       lat: double.tryParse(json['lat'].toString()) ?? 0.0,
       long:double.tryParse(json['long'].toString()) ?? 0.0,
       lst: (json['lst'] as List).map((item) => detail.fromJson(item)).toList(),
       ad_dat: json['ad_dat'] != null ? cuahang.fromJson(json['ad_dat']) : null,
       ad_nhan: json['ad_nhan'] ?? '',
       nguoinhan: json['nguoinhan'] != null
           ? user.fromJson(json['nguoinhan'])
           : null,
       sdt: json['sdt'] ?? '',
       sl: json['sl'] is int ? json['sl'] : int.tryParse(json['sl'].toString()) ?? 0,
       gia: json['gia'] is int ? json['gia'] : int.tryParse(json['gia'].toString()) ?? 0,
       giamgia: json['giamgia'] is int
           ? (json['giamgia'] as int).toDouble()
           : json['giamgia'] is double
           ? json['giamgia']
           : double.tryParse(json['giamgia'].toString()) ?? 0.0,
       phigiaohang: json['phigiaohang'] is int
           ? json['phigiaohang']
           : int.tryParse(json['phigiaohang'].toString()) ?? 0,
       times: json['timestamp'] is Timestamp
           ? (json['timestamp'] as Timestamp).toDate()
           : DateTime.now(),
         thanhtoan: json['thanhtoan'] ?? '',
       trangthai: json['trangthai'] ?? 'Đã xác nhận',
       shipper: json['shipper'] != null ? shippeUser.fromJson(json['shipper']) : null

     );
   }
   String getFormattedTime() {
     if (times != null) {
       DateFormat dateFormat = DateFormat("HH:mm dd:MM:yyyy");
       return dateFormat.format(times!);
     } else {
       return "Thời gian không hợp lệ";
     }
   }

}