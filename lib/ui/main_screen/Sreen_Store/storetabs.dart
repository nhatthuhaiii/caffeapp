import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/provider/user_provider.dart';
import 'package:caffeapp/ui/main_screen/Screen_search/searchtabstore.dart';
import 'package:caffeapp/ui/main_screen/Sreen_Store/storesingle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../src/cuahang.dart';
import 'Screen_direction/MapScreeen.dart';
import 'package:geolocator/geolocator.dart';

class storetabs extends StatefulWidget {
  @override
  _storetabsState createState() => _storetabsState();
}

class _storetabsState extends State<storetabs> {
  Position? userLocation;
  List<cuahang> lst = [];
  List<cuahang> filtteList =[];


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userLocation=null;
    filtteList=[];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    lst=context.read<getData>().listcuahang;
      _getUserLocation();


  }
  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        userLocation = position;
        _filterStores();
      });
    } catch (e) {
      setState(() {
        userLocation = null;
      });
    }
  }
  void _filterStores() {

    if (userLocation == null)
      return;
    List<cuahang> tempList = lst.where((store) {
      double distance = Geolocator.distanceBetween(
        userLocation!.latitude,
        userLocation!.longitude,
        store.lattidude!,
        store.longatitude!,
      ) / 1000;
      print(distance);
      return distance >= 1 && distance <=  8.5 || distance <=5;
    }).toList();

    setState(() {
      filtteList = tempList;
    });
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  margin: EdgeInsets.only(top: 10, left: 12),
                  child: Row(
                    children: [
                      Icon(Icons.home_outlined, size: 30),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "Cửa hàng",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12, top: 5),
                    child: Text(
                      "Bản đồ",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              margin: EdgeInsets.only(left: 12, right: 12, top: 5),
              height: 50,
              decoration: BoxDecoration(
                  border:
                  Border.all(color: Colors.yellowAccent.withOpacity(0.3)),
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                readOnly: true,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Tìm Kiếm Quán",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                  suffixIcon:
                  Icon(Icons.search, color: Colors.black.withOpacity(0.3)),
                ),
                onTap: () {
                  showSearch(context: context, delegate: searchtabstore());
                },
              ),
            ),
            SizedBox(height: 10),
           Container(

             child: Column(
                          children: [
             Container(

               alignment: Alignment.topLeft,
               margin: EdgeInsets.only(left: 12),
               child: Text(
                 "Các Cửa Hàng gần vị trí của bạn ",
                 style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                     color: Colors.black.withOpacity(0.8)),
               ),
             ),

            filtteList ==null || filtteList.isEmpty ? Center(
              child: Column(
                children: [
                  Text("Không tìm thấy quán nào ở gần đây cả :<"),
                  CircularProgressIndicator(),
                ],
              ),
            ) : filtteList == null  ? Center(child: Text("Không tìm thấy quán nào bạn")):

             Column(
               children: [




                 for (int i = 0; i < filtteList.length; i++)
                   Container(
                     margin: EdgeInsets.only(top: 10),
                     child: Column(
                       children: [
                         InkWell(
                           onTap: () {
                             showModalBottomSheet(
                               context: context,
                               isScrollControlled: true,
                               builder: (context) {
                                 return FractionallySizedBox(
                                   heightFactor: 0.9,
                                   child: storesingle(tencuahang: filtteList[i]),
                                 );
                               },
                             );
                           },
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
                                     "${filtteList[i].url}",
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
                                         child: Text("${filtteList[i].diachi}"),
                                       )
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         SizedBox(height: 10),
                       ],
                     ),
                   ),
               ],
             )



                          ],

                        ),
           ),






            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 12),
              child: Text(
                "Các Cửa Hàng Khác ",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8)),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [




                    for (int i = 0; i < lst.length; i++)
                      Container(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                      heightFactor: 0.9,
                                      child: storesingle(tencuahang: lst[i]),
                                    );
                                  },
                                );
                              },
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
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
