class user {
  String name;
  String userName;
  String pass;
  String phoneNumber;
  String? url;
  List<String> fv;
  double? lat;
  double? long;
  user({
    required this.name,
    required this.userName,
    required this.pass,
    required this.phoneNumber,
    this.url = "https://i.ibb.co/V04bgZS4/bacxiu.jpg",
    this.lat,
    this.long,
    List<String>? fv,
  }) : fv = fv ?? [];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userName': userName,
      'pass': pass,
      'phoneNumber': phoneNumber,
      'url': url,
      'fv': fv,
      'lat': lat,
      'long:': long,
    };
  }

  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      name: json['name'] ?? '',
      userName: json['account'] ?? '',
      pass: json['pass'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      url: json['url'] ?? 'images/cons.jpg',
      lat: json['lat']?? 0,
      long: json['long']?? 0,
      fv: (json['lstFv'] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
    );
  }
}
