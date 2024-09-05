class cuahang {
  String? xeoto;
  String? taicho;
  String? muave;
  String? giomocua;
  String? mota;
 late String diachi;
  String? url ;
  String? qc1;
  String? qc2;
  String? qc3;
  cuahang(String a, String b,String c,String d,String xeoto,String taicho,String muave,String qc1,String qc2,String qc3){
    this.url=b;
    this.diachi=a;
    this.muave=muave;
    this.taicho=taicho;
    this.xeoto=xeoto;
    this.giomocua=c;
    this.mota=d;
    this.qc1=qc1;
    this.qc2=qc2;
    this.qc3=qc3;
  }
   static List<String> getDiachiAll(List<cuahang> a){
    List<String> lst=[];
    for(cuahang it in a )
        lst.add(it.diachi);
    return lst;
  }

  static List<cuahang> getList(){
    List<cuahang>  lst = [];
    cuahang a = new cuahang("TTTM Crescent Mall, 101 Tôn Dật Tiên, Phường Tân Phú, Quận 7, Thành phố Hồ Chí Minh ",
        "images/101tondattien.jfif","07:00 - 22:00",
    "Nhà tin rằng “cuộc hẹn cà phê” luôn có cho mình những tiêu chuẩn, phiên bản khác nhau, chúng luôn biến hoá mỗi ngày. Và SIGNATURE by The Coffee House là nơi bạn tìm thấy phiên bản đặc biệt của Cuộc hẹn tròn đầy giữa những ngày hối hả"
        ".Hôm nay bạn có hẹn chưa? Mình cà phê nhé!","Có chỗ đỗ xe hơi",
        "Phục vụ tại chổ","Mua Mang đi","images/tondiendatqc.jfif","images/tondiendatqc2.jfif","images/tondiendatqc3.jfif");

    cuahang b  = new cuahang("58 Lâm Văn Bền, Phường Tân Kiểng, Quận 7, Hồ Chí Minh", "images/lamvanben.png","07:00 - 21:30","Vậy là đường đến Nhà của team quận 7 đã ngắn hơn được xíu rồi nha. Cùng ngắm không gian Nhà mới xịn sò"
        " tại 58 Lâm Văn Bền, Q.7, TP.HCM xem đã đủ làm bạn xiêu lòng chưa nào.",
        "Có chỗ đỗ xe hơi","Phục vụ tại chỗ","Mua mang đi","images/lamvanbenqc1.jfif","images/lamvanbenqc3.jfif","images/lamvanbenqc22.jfif");
    cuahang c = new cuahang("400A Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh","images/huynhtanphat.jpg","07:00 - 21:30","Cửa hàng The Coffee House Huỳnh Tấn Phát mang không rộng lớn, thoáng đãng nhưng vẫn giữ được sự ấm cúng. Cùng với hương vị Nhà quen thuộc, đây sẽ là địa điểm vô cùng thích hợp cho những buỗi hẹn họ"
        " cùng người thương hay tụ tập tám chuyện cùng bạn bè mỗi ngày.",
        "Có chỗ đỗ xe hơi","Phục vụ tại chỗ","Mua mang đi","images/huynhtanphatqc1.jfif","images/huynhtanphatqc2.jfif","images/huynhtanphatqc3.jfif");
    cuahang d = new cuahang("490-492 Nguyễn Thị Thập, Quận 7, Hồ Chí Minh", "images/nguyenthithap.jfif","07:00 - 21:30","Quận 3 Nhà mới có gì, Quận 7 cũng có  gì quận 3. Ra mắt cùng ngày 25.07 với cửa hàng Rạch Bùng Binh quận 3, "
        "Nhà mới tại 490 - 492 Nguyễn Thị Thập quận 7 cũng không hề kém cạnh với không gian ấm áp, "
        "sang trọng và những dãy bàn cạnh khung kính đặc trưng.",
        "Có chỗ đỗ xe hơi","Phục vụ tại chổ","Mua Mang đi","images/nguyenthithapqc1.jfif","images/nguyenthithapqc2.jfif","images/nguyenthithapqc3.jfif");


    lst.add(a);
    lst.add(b);
    lst.add(c);
    lst.add(d);



    return lst;
  }

}