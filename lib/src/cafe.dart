class caffe {
  String? ma;
  late String ten;
  String? url;
  late int gia;
  String? mota;

  caffe(String a ,String b, String c, int d, String mota) {
    this.ma=a;
    this.ten = b;
    this.url = c;
    this.gia = d;
    this.mota = mota;
  }

  static List<caffe> getList() {
    List< caffe> lst = [];
    caffe a = new caffe("1","Đường đen sữa đá", "images/duongden_suada.JPG", 45,
        "Nếu chuộng vị cà phê đậm đà, bùng nổ và thích vị đường đen ngọt thơm, Đường Đen Sữa Đá đích thị là thức uống dành cho bạn. Không chỉ giúp bạn tỉnh táo buổi sáng, Đường Đen Sữa Đá còn hấp dẫn đến ngụm cuối cùng bởi thạch cà phê giòn dai, nhai cực cuốn. - Khuấy đều trước khi sử dụng");
    caffe b = new caffe("2","Cà phê sữa nóng", "images/caphe_suanong.JPG", 39,
        "Cà phê được pha phin truyền thống kết hợp với sữa đặc tạo nên hương vị đậm đà, hài hòa giữa vị ngọt đầu lưỡi và vị đắng thanh thoát nơi hậu vị");
    caffe c = new caffe("3","Cà phê sữa đá", "images/caphe_suada.JPG", 29,
        "Cà phê Đắk Lắk nguyên chất được pha phin truyền thống kết hợp với sữa đặc tạo nên hương vị đậm đà, hài hòa giữa vị ngọt đầu lưỡi và vị đắng thanh thoát nơi hậu vị.");
    caffe d = new caffe("4","Bạc xỉu", "images/bacxiu.JPG", 29,
        "Bạc sỉu chính là 'Ly sữa trắng kèm một chút cà phê'. Thức uống này rất phù hợp những ai vừa muốn trải nghiệm chút vị đắng của cà phê vừa muốn thưởng thức vị ngọt béo ngậy từ sữa.");
    caffe e = new caffe("5","Caramel Đá", "images/caramel_da.JPG", 55,
        "Khuấy đều trước khi sử dụng Caramel Macchiato sẽ mang đến một sự ngạc nhiên thú vị khi vị thơm béo của bọt sữa, sữa tươi, vị đắng thanh thoát của cà phê Espresso hảo hạng và vị ngọt đậm của sốt caramel được gói gọn trong một tách cà phê.");


    caffe f = new caffe("6","Hồng trà trân châu", "images/hongtra_tranchau.JPG", 57,
        "Thêm chút ngọt ngào cho ngày mới với hồng trà nguyên lá, sữa thơm ngậy được cân chỉnh với tỉ lệ hoàn hảo, cùng trân châu trắng dai giòn có sẵn để bạn tận hưởng từng ngụm trà sữa ngọt ngào thơm ngậy thiệt đã.");
    caffe g = new caffe("7",
        "Oolong tứ quý sen-nóng",
        "images/tuquy_sennong.JPG",
        49,
        "Nền trà oolong hảo hạng kết hợp cùng hạt sen tươi, bùi bùi thơm ngon. Trà hạt sen là thức uống thanh mát, nhẹ nhàng phù hợp cho cả buổi sáng và chiều tối.");
        caffe h = new caffe("8",
        "Oolong tứ quý trân châu",
        "images/tuquy_tranchau.JPG",
        55,
        "Đậm hương trà, sảng khoái du xuân cùng Oolong Tứ Quý Kim Quất Trân Châu. Vị nước cốt kim quất tươi chua ngọt, thêm trân châu giòn dai.");
        caffe ab = new caffe("9","Trà đào cam xã-nóng", "images/dao_camxa.JPG", 59,
        "Vị thanh ngọt của đào, vị chua dịu của Cam Vàng nguyên vỏ, vị chát của trà đen tươi được ủ mới mỗi 4 tiếng, cùng hương thơm nồng đặc trưng của sả chính là điểm sáng làm nên sức hấp dẫn của thức uống này.");
        caffe k = new caffe("10","Oolong tứ quý vải", "images/tuquy_vai.JPG", 49,
        "Đậm hương trà, thanh mát sắc xuân với Oolong Tứ Quý Vải. Cảm nhận hương hoa đầu mùa, hòa quyện cùng vị vải chín mọng căng tràn sức sống.");
      caffe ac= new caffe("11","Hồng trà sữa nóng","images/hongtra_nong.JPG",59,"Từng ngụm trà chuẩn gu ấm áp, đậm đà beo béo bởi lớp sữa tươi chân ái hoà quyện. Trà đen nguyên lá âm ấm dịu nhẹ, quyện cùng lớp sữa thơm béo khó lẫn - hương vị ấm áp chuẩn gu trà, cho từng ngụm nhẹ nhàng, ngọt dịu lưu luyến mãi nơi cuống họng.");



     caffe ad= new caffe("12","Trà sữa nướng sương sáo","images/trasua_suongsao.JPG",54,"Tận hưởng hương vị Oolong nướng đậm đà được Nhà rang kỹ càng, quyện cùng sữa thơm béo, càng thêm hấp dẫn với sương sáo thanh mát.");
   caffe ae = new caffe("13","Trà đen macchiato","images/traden.JPG",53,"Trà đen được ủ mới mỗi ngày, giữ nguyên được vị chát mạnh mẽ đặc trưng của lá trà, phủ bên trên là lớp Macchiato homemade bồng bềnh quyến rũ vị phô mai mặn mặn mà béo béo.");
   caffe af= new caffe("14","Trà sữa nướng trân châu","images/nuong_tranchau.JPG",52,"Hương vị chân ái đúng gu đậm đà với trà oolong được “sao” (nướng) lâu hơn cho hương vị đậm đà, hòa quyện với sữa thơm béo mang đến cảm giác mát lạnh, lưu luyến vị trà sữa đậm đà nơi vòm họng.");
     caffe ak = new caffe("15","Hồng trà sữa trân châu","images/hongtra_tranchau.JPG",51,"Thêm chút ngọt ngào cho ngày mới với hồng trà nguyên lá, sữa thơm ngậy được cân chỉnh với tỉ lệ hoàn hảo, cùng trân châu trắng dai giòn có sẵn để bạn tận hưởng từng ngụm trà sữa ngọt ngào thơm ngậy thiệt đã.");









    lst.add(a);
    lst.add(b);
    lst.add(c);
    lst.add(d);
    lst.add(e);

    lst.add(f);
    lst.add(ab);
    lst.add(g);
    lst.add(k);
    lst.add(h);
    lst.add(ac);
    lst.add(ad);
    lst.add(af);
    lst.add(ae);
    lst.add(ak);
    return lst;
  }

  int? getGia() {
    return this.gia;
  }

  String? geturl() {
    return this.url;
  }

  String? getten() {
    return this.ten;
  }

  String? getma() {
    return this.ma;
  }
}
