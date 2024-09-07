import 'package:cloud_firestore/cloud_firestore.dart';

class cuahang {
  String? id;
  double? longatitude;
  double? lattidude;
  late String diachi;
  String? url ;
  String? qc1;
  String? qc2;
  String? qc3;
  cuahang({
    required this.id,
    required this.lattidude,
    required this.longatitude,
    required this.diachi,
    this.url,
    this.qc1,
    this.qc2,
    this.qc3,
  });





   static List<String> getDiachiAll(List<cuahang> a){
    List<String> lst=[];
    for(cuahang it in a )
        lst.add(it.diachi);
    return lst;
  }






  // static List<cuahang> getList(){
  //   List<cuahang>  lst = [];
  //   cuahang a = cuahang(
  //     required this.id,
  //    lattidude: 10.729567,
  //     longatitude: 106.719413,
  //     diachi: "TTTM Crescent Mall, 101 Tôn Dật Tiên, Phường Tân Phú, Quận 7, TP. HCM",
  //     url: "images/101tondattien.jfif",
  //     qc1: "images/tondiendatqc.jfif",
  //     qc2: "images/tondiendatqc2.jfif",
  //     qc3: "images/tondiendatqc3.jfif",
  //   );
  //
  //   cuahang b = cuahang(
  //     lattidude: 10.738045,
  //     longatitude: 106.709239,
  //     diachi: "58 Lâm Văn Bền, Phường Tân Kiểng, Quận 7, TP. HCM",
  //     url: "images/lamvanben.png",
  //     qc1: "images/lamvanbenqc1.jfif",
  //     qc2: "images/lamvanbenqc3.jfif",
  //     qc3: "images/lamvanbenqc22.jfif",
  //   );
  //
  //   cuahang c = cuahang(
  //     lattidude: 10.721489,
  //     longatitude: 106.714843,
  //     diachi: "400A Huỳnh Tấn Phát, Quận 7, TP. HCM",
  //     url: "images/huynhtanphat.jpg",
  //     qc1: "images/huynhtanphatqc1.jfif",
  //     qc2: "images/huynhtanphatqc2.jfif",
  //     qc3: "images/huynhtanphatqc3.jfif",
  //   );
  //
  //   cuahang d = cuahang(
  //    lattidude: 10.738810,
  //     longatitude: 106.714964,
  //     diachi: "490-492 Nguyễn Thị Thập, Quận 7, TP. HCM",
  //     url: "images/nguyenthithap.jfif",
  //     qc1: "images/nguyenthithapqc1.jfif",
  //     qc2: "images/nguyenthithapqc2.jfif",
  //     qc3: "images/nguyenthithapqc3.jfif",
  //   );
  //   cuahang e = cuahang(lattidude: 16.4588069, longatitude: 107.5930998,
  //     diachi:"77 Nguyễn Huệ,  Thành phố Huế",
  //   url:"images/dhkh.jpg",
  //     qc1: "images/dhkh1.jpg",
  //     qc2: "images/dhkh2.jpg",
  //     qc3: "images/dhkh3.jpg",
  //   );
  //
  //
  //   lst.add(a);
  //   lst.add(b);
  //   lst.add(c);
  //   lst.add(d);
  //   lst.add(e);
  //
  //
  //
  //   return lst;
  // }

  Map<String, dynamic> toJson() {
    return {
      'latitude': lattidude,
      'longitude': longatitude,
      'diachi': diachi,
      'url': url,
      'qc1': qc1,
      'qc2': qc2,
      'qc3': qc3,
    };
  }

  factory cuahang.fromJson(Map<String, dynamic> json) {
    return cuahang(
      id: json['id'] as String?,
      lattidude: (json['latitude'] as num?)?.toDouble(),
      longatitude: (json['longitude'] as num?)?.toDouble(),
      diachi: json['diachi'] as String,
      url: json['url'] as String?,
      qc1: json['qc1'] as String?,
      qc2: json['qc2'] as String?,
      qc3: json['qc3'] as String?,
    );
  }
}