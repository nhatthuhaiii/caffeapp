

import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../../provider/getData.dart';
import '../../../../src/cafe.dart';
import '../../admin_function/firebase_Utils.dart';

class admin_products_item extends StatefulWidget {
   admin_products_item({super.key,required this.item});
  Caffe? item;
  @override
  State<admin_products_item> createState() => _admin_products_itemState();
}

class _admin_products_itemState extends State<admin_products_item>
{
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  File? _selectedImage;
  final picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<firebase_Utils>().setProduct(widget.item!);
    nameController = TextEditingController(text: widget.item!.ten);
    priceController = TextEditingController(text: widget.item!.gia.toString());
    descriptionController = TextEditingController(text: widget.item!.mota);
    imageController = TextEditingController(text: widget.item!.url);



  }
  Future<void> pickAndUploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

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
        setState(() {
          imageController.text = uploadedUrl;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload thành công!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload thất bại!")));
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    context.read<firebase_Utils>().clearProduct();

  }
  void saveToFirebase() async{
    final product = Provider.of<firebase_Utils>(context, listen: false).product;
    Map<String, dynamic> updatedData = {};

    if(nameController.text != product!.ten){
      updatedData['ten'] = nameController.text;
    }
    if(descriptionController.text != product.mota){
      updatedData['mota'] = descriptionController.text;
    }
    if(imageController.text != product.url){
      updatedData['url'] = imageController.text;
    }
    if(priceController.text  != product.gia.toString()){
      updatedData['gia'] = int.parse(priceController.text);
    }

    try {
      await firebase_Utils.updateCaffeByFieldId(fieldId: '${product.ma}', updatedData: updatedData);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thông tin đã được lưu và cập nhật!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: ${e.toString()}")),
      );
    }





  }



  @override
  Widget build(BuildContext context) {



    return SafeArea(child: Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     showModalBottomSheet(context: context, builder: (context)=>Padding(
      //       padding: EdgeInsets.all(16),
      //       child: Column(
      //         children: [
      //           Text("Thêm mới sản phẩm"),
      //           TextField(
      //             controller: nameController,
      //             decoration: InputDecoration(labelText: 'Tên sản phẩm:'),
      //           ),
      //
      //           TextField(
      //             controller: priceController,
      //             decoration: InputDecoration(labelText: 'giá:'),
      //           ),
      //           TextField(
      //             controller: descriptionController,
      //             decoration: InputDecoration(labelText: 'mô tả:'),
      //           ),
      //           TextField(
      //             controller: imageController,
      //             decoration: InputDecoration(labelText: 'link hình ảnh:'),
      //           ),
      //
      //
      //           SizedBox(height: 20),
      //           // ElevatedButton(onPressed: () async {
      //           //   Caffe a = Caffe(ma: (lst.length+1).toString(),
      //           //       ten: nameController.text,
      //           //       url: imageController==null?"":imageController.text,
      //           //       gia: int.parse(priceController.text),
      //           //       mota: descriptionController.text == null?"":descriptionController.text ,
      //           //       isfv: false);
      //           //
      //           //   firebase_Utils.addCaffe(a);
      //           //   Navigator.pop(context);
      //           //
      //           //
      //           // }, child: Text("Thêm")),
      //         ],
      //       ),
      //     ),);
      //
      //
      //
      //   },
      //   backgroundColor: Colors.orangeAccent,
      //   child: Icon(Icons.add, color: Colors.white,),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("${widget.item!.ten}"), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [


              _selectedImage != null
                  ? Image.file(_selectedImage!, height: 150)
                  : imageController.text.isNotEmpty
                  ? Image.network(imageController.text, height: 150)
                  : Container(
                height: 150,
                color: Colors.grey[300],
                child: Center(child: Text("Chưa có ảnh")),
              ),
              SizedBox(height: 10,),
              ElevatedButton.icon(

                onPressed: pickAndUploadImage,

                icon: Icon(Icons.image, color: Colors.orangeAccent,),
                label: Text("Chọn ảnh từ máy",style: TextStyle(color: Colors.black),),
              ),
              TextField(
                controller: nameController,


                decoration: InputDecoration(
                  labelText: "Tên sản phẩm",
                  hintText: "Ví dụ: ${widget.item!.ten}", // Gợi ý thông tin cũ
                ),
              ),

              SizedBox(height: 10),

              TextField(
                maxLines: 3,
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Thông tin",
                  hintText: widget.item!.mota
                ),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "Giá",
                  hintText: widget.item!.gia.toString(),
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveToFirebase,
                child: Text("Lưu"),
              ),
            ],
          ),
        ),
      )      ,


    ));
  }
}
