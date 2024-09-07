class shippeUser {
  String? name;
  String? id;
  String? phone;
  bool? status;
  double? lat;
  double? long;
  String? userName;
  String? pass;

  shippeUser({
    this.name,
    this.id,
    this.phone,
    this.status,
    this.lat,
    this.long,
    this.userName,
    this.pass,
  });

  // Tạo từ Map (dùng khi đọc từ Firestore hoặc JSON)
  factory shippeUser.fromJson(Map<String, dynamic> json) {
    return shippeUser(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      status: json['status'],
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      userName: json['userName'],
      pass: json['pass'],
    );
  }

  // Chuyển thành Map (dùng để ghi vào Firestore hoặc chuyển thành JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'status': status,
      'lat': lat,
      'long': long,
      'userName': userName,
      'pass': pass,
    };
  }
}
