import 'dart:convert';

import 'package:caffeapp/ui/admin_screen/admin_function/firebase_Utils.dart';
import 'package:caffeapp/ui/admin_screen/admin_products_screen/admin_products_item/admin_products_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/getData.dart';
import '../../../src/cafe.dart';
import 'package:http/http.dart' as http;
import '../../cafeapp.dart';
import 'dart:io';


class admin_products_screen extends StatefulWidget {
  const admin_products_screen({super.key});

  @override
  State<admin_products_screen> createState() => _admin_products_screenState();
}

class _admin_products_screenState extends State<admin_products_screen> {
  List<Caffe> lst = [];
  File? _selectedImage;
  final picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    lst = context.read<getData>().listcaffe;
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController imageController = TextEditingController();


    Future<void> pickImageAndUpload(ImageSource source) async {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);

        final base64Image = base64Encode(await _selectedImage!.readAsBytes());
        final response = await http.post(
          Uri.parse("https://api.imgbb.com/1/upload"),
          body: {
            "key": "1b7f64a0891e1ca28d5c77592763cfff",
            "image": base64Image,
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final uploadedUrl = data["data"]["url"];
          imageController.text = uploadedUrl;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Tải ảnh lên thành công!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Tải ảnh thất bại!")),
          );
        }
      }
    }

    return SafeArea(child: Scaffold(

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Text(
                          "Thêm mới sản phẩm",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Tên sản phẩm',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.coffee),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: priceController,
                        decoration: InputDecoration(
                          labelText: 'Giá',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Mô tả',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 16),
                      Text("Hình ảnh sản phẩm", style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),




                      Align(
                        alignment: Alignment.topLeft,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          icon: Icon(Icons.photo,color: Colors.white,),
                          label: Text("Chọn ảnh từ thiết bị",style: TextStyle(color: Colors.white),),
                          onPressed: () => {
                            pickImageAndUpload(ImageSource.gallery)

                          },
                        ),
                      ),

                      SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            Caffe a = Caffe(
                              ma: (lst.length + 1).toString(),
                              ten: nameController.text,
                              url: imageController.text,
                              gia: int.parse(priceController.text),
                              mota: descriptionController.text,
                              isfv: false,
                            );
                            await firebase_Utils.addCaffe(a);
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Đã thêm sản phẩm mới")),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                            child: Text("Thêm sản phẩm", style: TextStyle(fontSize: 16,color: Colors.white)),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          backgroundColor: Colors.orangeAccent,
          child: Icon(Icons.add, color: Colors.white),
        ),

        body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12,right: 12,
                top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sản Phẩm", style: TextStyle(fontSize: 18)),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>caffeapp(currentPage: NavigationPages.home)));
                }, icon: Icon(Icons.logout))
              ],
            ),
          ),
          Expanded( // Wraps the scrollable content to make it fit within the available space
            child: SingleChildScrollView(
              child: Selector<getData,List<Caffe>>(
                builder: (BuildContext context, List<Caffe> value, Widget? child) {
                  List<Caffe> lst = value;
                  return Column(
                    children: [
                      Divider(),
                      for (int i = 0; i < lst.length; i++)

                        Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(onPressed: (context){
                                  showModalBottomSheet(context: context, isScrollControlled: true,builder: (context)=>
                                      FractionallySizedBox(
                                        heightFactor: 0.8,
                                        child: admin_products_item(item: lst[i]),
                                      ));

                                }, icon: Icons.edit,backgroundColor: Colors.blue,),


                                SlidableAction(

                                  onPressed:(context){


                                    showDialog(context: context, builder: (context)=>

                                        AlertDialog(
                                            content: Text("Xác nhận xoá sản phẩm ${lst[i].ten}"),
                                            actions: [
                                              TextButton(onPressed: (){

                                                firebase_Utils.deleteProductByFieldMa(lst[i].ma!);
                                                Navigator.pop(context);
                                                context.read<getData>().getListStream();
                                              },
                                                  child: Text("Xoá",style: TextStyle(color: Colors.red),)),
                                              TextButton(onPressed: (){
                                                Navigator.pop(context);

                                              },child: Text("Huỷ"),)
                                            ]
                                        )
                                    );

                                  },

                                  icon: Icons.delete,backgroundColor: Colors.red,)

                              ],
                            ),
                            child:Container(
                              margin: EdgeInsets.only(left: 12, top: 10, right: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.yellowAccent.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white12,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                    child: Image.network(
                                        lst[i].url,
                                        height: 90,
                                        width: 90,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset("images/brand_logo2.jpg", height: 90,width: 90,);
                                        }
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Text(lst[i].ten),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${lst[i].gia}.000VNĐ"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))

                    ],
                  );
                },

                selector: (BuildContext , getData ) { return getData.listcaffe; },

              ),
            ),
          ),
        ],
      )
      ,


    ));
  }
}
