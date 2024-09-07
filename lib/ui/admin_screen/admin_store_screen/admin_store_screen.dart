import 'dart:convert';

import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/ui/admin_screen/admin_function/firebase_Utils.dart';
import 'package:caffeapp/ui/admin_screen/admin_store_screen/admin_store_item/admin_store_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../src/cuahang.dart';
import '../../main_screen/Sreen_Store/storesingle.dart';

class admin_store_screen extends StatefulWidget {
  const admin_store_screen({super.key});

  @override
  State<admin_store_screen> createState() => _admin_store_screenState();
}

class _admin_store_screenState extends State<admin_store_screen> {
  List<cuahang> lst = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lst= context.read<getData>().listcuahang;
  }


  Future<Position?> getLatLngFromGraphHopper(String address) async {
    String apiKey = "ec614973-73ab-42f6-8fe4-a5ba3c05cb39";
    String url = "https://graphhopper.com/api/1/geocode?q=${Uri.encodeComponent(address)}&locale=vi&limit=1&key=$apiKey";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["hits"].isNotEmpty) {
          var location = data["hits"][0]["point"];
          return Position(
            latitude: location["lat"],
            longitude: location["lng"],
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0,
          );
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController();
    final TextEditingController ad1Controller = TextEditingController();
    final TextEditingController urlController = TextEditingController();
    final TextEditingController ad2Controller = TextEditingController();
    final TextEditingController ad3Controller = TextEditingController();
    return SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context)=>Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Thêm mới cửa hàng"),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Địa chỉ'),
                ),

                TextField(
                  controller: urlController,
                  decoration: InputDecoration(labelText: 'URL'),
                ),
                TextField(
                  controller: ad1Controller,
                  decoration: InputDecoration(labelText: 'Quảng cáo 1'),
                ),
                TextField(
                  controller: ad2Controller,
                  decoration: InputDecoration(labelText: 'Quảng cáo 2'),
                ),
                TextField(
                  controller: ad3Controller,
                  decoration: InputDecoration(labelText: 'Quảng cáo 3'),
                ),

                SizedBox(height: 20),
                ElevatedButton(onPressed: () async {
                  Position? store_new = await getLatLngFromGraphHopper(addressController.text)!;

                  cuahang item = cuahang(id: (lst.length+1).toString(), url: urlController.text, lattidude: store_new!.latitude, longatitude: store_new!.longitude,
                      diachi: addressController.text,
                      qc1: ad1Controller==null?"":ad1Controller.text,
                      qc2: ad2Controller==null?"":ad2Controller.text,
                      qc3: ad3Controller==null?"":ad3Controller.text);
                    firebase_Utils.addStore(item);
                    Navigator.pop(context);


                }, child: Text("Thêm")),
              ],
            ),
          ),);

        },

      ),
      body: Container(
        margin: EdgeInsets.only(left: 12,right: 12,top:10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Cửa hàng",style: TextStyle(fontSize: 18),),

              ],),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < lst.length; i++)
                    Column(
                      children: [
                        Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(onPressed: (context){
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return FractionallySizedBox(
                                        heightFactor: 0.9,
                                        child: admin_store_item(store: lst[i],),
                                      );
                                    },
                                  );

                                }, icon: Icons.edit,backgroundColor: Colors.blue,),


                                SlidableAction(

                                  onPressed: (context) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Text("Xác nhận xoá cửa hàng ${lst[i].diachi}"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              firebase_Utils.deleteStoreByFieldId(lst[i].diachi!);
                                              Navigator.pop(context); // Đóng AlertDialog
                                              context.read<getData>().getCuaHangListStream(); // Làm mới dữ liệu
                                            },
                                            child: Text("Xoá", style: TextStyle(color: Colors.red)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context); // Đóng AlertDialog
                                            },
                                            child: Text("Huỷ"),
                                          )
                                        ],
                                      ),
                                    );
                                  },


                                  icon: Icons.delete,backgroundColor: Colors.red,)

                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.yellowAccent.withOpacity(0.35)),
                              ),
                              margin: EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                children: [
                                  Container(
                                    margin:
                                    EdgeInsets.only(left: 10, right: 10),
                                    child: Image.network(
                                      "${lst[i].url}",
                                      height: 100,
                                      width: 100,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset("images/brand_store.jpg",width: 100,height: 100,);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "COFFE HOME",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text("${lst[i].diachi}"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),


    ));;
  }
}
