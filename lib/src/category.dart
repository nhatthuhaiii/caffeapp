class CategoryList {
  String? name;
  String? urlImage;

  CategoryList({required this.name , required this.urlImage});


  static List<CategoryList> GetListCategory(){
     List<CategoryList>  lst = [];
     CategoryList a =CategoryList(name: "Nóng", urlImage: "images/catefory_monnong.jpg");
     CategoryList b=CategoryList(name:"Bánh",urlImage: "images/category_banh.jpg");
     CategoryList c = CategoryList(name:"Cà Phê",urlImage: "images/category_caffe.jpg");
     CategoryList d=CategoryList(name:"Trà",urlImage: "images/category_tra.jpg");
     CategoryList e = CategoryList(name: "Frosty", urlImage: "images/category_daxay.jpg");
     CategoryList f = CategoryList(name: "Bánh Ngọt", urlImage:"images/category_banhngot.jpg");
    lst.add(a);
    lst.add(b);
    lst.add(c);
    lst.add(d);
    lst.add(f);
    lst.add(e);

    return lst;


  }





}