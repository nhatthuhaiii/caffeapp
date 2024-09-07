import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/ui/admin_screen/admin_function/firebase_Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../src/cuahang.dart';

class admin_store_item extends StatefulWidget {
  admin_store_item({super.key,required this.store});
  cuahang? store;
  @override
  State<admin_store_item> createState() => _admin_store_itemState();
}

class _admin_store_itemState extends State<admin_store_item> {
  late TextEditingController diachiController;
  late TextEditingController urlController;
  late TextEditingController qc1Controller;
  late TextEditingController qc2Controller;
  late TextEditingController qc3Controller;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<firebase_Utils>().setStore(widget.store!);
    //final store = Provider.of<firebase_Utils>(context, listen: false).store;
    diachiController = TextEditingController(text: widget.store!.diachi);
    urlController = TextEditingController(text: widget.store!.url ?? "");
    qc1Controller = TextEditingController(text: widget.store!.qc1 ?? "");
    qc2Controller = TextEditingController(text: widget.store!.qc2 ?? "");
    qc3Controller = TextEditingController(text: widget.store!.qc3 ?? "");
  }
  @override
  void dispose() {
    diachiController.dispose();
    urlController.dispose();
    qc1Controller.dispose();
    qc2Controller.dispose();
    qc3Controller.dispose();
    context.read<firebase_Utils>().clearStore(); // Clear store
    super.dispose();
  }


  void saveToFirebase() async {
    final store = Provider.of<firebase_Utils>(context, listen: false).store;

    Map<String, dynamic> updatedData = {};
    if(diachiController.text != store?.diachi) {
      updatedData['diachi'] = diachiController.text;
    }
    if (urlController.text != store?.url) {
      updatedData['url'] = urlController.text;
    }
    if (qc1Controller.text != store?.qc1) {
      updatedData['qc1'] = qc1Controller.text;
    }
    if (qc2Controller.text != store?.qc2) {
      updatedData['qc2'] = qc2Controller.text;
    }
    if (qc3Controller.text != store?.qc3) {
      updatedData['qc3'] = qc3Controller.text;
    }

    try {
      await firebase_Utils.updateStoreByFieldId(fieldId: '${store!.id}', updatedData: updatedData);
      Navigator.pop(context);
      context.read<getData>().getCuaHangListStream();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thông tin đã được lưu và cập nhật!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: ${e.toString()}")),
      );
    }
  }





  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa cửa hàng"),


      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: diachiController,


                decoration: InputDecoration(
                  labelText: "Địa chỉ",
                  hintText: "Ví dụ: ${widget.store!.diachi}", // Gợi ý thông tin cũ
                ),
              ),
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: "URL hình ảnh",
                  hintText: widget.store!.url ?? "Chưa có URL", // Gợi ý URL cũ
                ),
              ),
              TextField(
                controller: qc1Controller,
                decoration: InputDecoration(
                  labelText: " Hình Ảnh 1",
                  hintText: widget.store!.qc1 ?? "Chưa có thông tin QC1",
                ),
              ),
              TextField(
                controller: qc2Controller,
                decoration: InputDecoration(
                  labelText: "Hình ảnh 2",
                  hintText: widget.store!.qc2 ?? "Chưa có thông tin QC2",
                ),
              ),
              TextField(
                controller: qc3Controller,
                decoration: InputDecoration(
                  labelText: "Hình ảnh 3",
                  hintText: widget.store!.qc3 ?? "Chưa có thông tin QC3",
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
      ),
    );
  }
}
