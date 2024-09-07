  import 'package:caffeapp/provider/detail_drink.dart';
import 'package:caffeapp/provider/order_provider.dart';
  import 'package:caffeapp/provider/user_provider.dart';
  import 'package:caffeapp/ui/main_screen/Sreen_Store/Screen_direction/MapDirection.dart';
  import 'package:caffeapp/ui/main_screen/Screen_Login/signintabs.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/foundation.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
  import 'package:flutter_map/flutter_map.dart';
  import 'package:latlong2/latlong.dart';
  //import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:provider/provider.dart';

  import '../../../src/cuahang.dart';

  class storesingle extends StatefulWidget {
     storesingle( {super.key,required this.tencuahang});
    cuahang? tencuahang;

    @override
    State<storesingle> createState() => _storesingleState();
  }

  class _storesingleState extends State<storesingle> {
    @override
    Widget build(BuildContext context) {
      double heigt = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      return  SafeArea(child:
      Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children:[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    ClipRRect(

                      child: ImageSlideshow(
                          autoPlayInterval: 3000,
                          indicatorColor:Colors.blue,
                          indicatorBackgroundColor: Colors.grey.shade200,
                          isLoop: true,
                          children: [
                            Image.network("${widget.tencuahang!.url}", fit: BoxFit.fill,errorBuilder: (context, error, stackTrace){
                              return Image.asset("images/brand_logo2.jpg", fit: BoxFit.fill);
                            },),
                            Image.network("${widget.tencuahang!.qc1}", fit: BoxFit.fill,errorBuilder: (context, error, stackTrace){
                              return Image.asset("images/brand_logo2.jpg", fit: BoxFit.fill);
                            }),
                            Image.network("${widget.tencuahang!.qc2}", fit: BoxFit.fill,errorBuilder: (context, error, stackTrace){
                              return Image.asset("images/brand_logo2.jpg", fit: BoxFit.fill);
                            }),
                            Image.network("${widget.tencuahang!.qc3}", fit: BoxFit.fill,errorBuilder: (context, error, stackTrace){
                              return Image.asset("images/brand_logo2.jpg", fit: BoxFit.fill);
                            }),

                          ]
                      ),
                    ),

                    Column(

                      children: [

                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.only(left: 8),

                          child: Text("The Coffe House",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,


                            ),),),


                        // Container(
                        //   margin: EdgeInsets.only(left: 8,right: 8,top: 10),
                        //   child: Text("${widget.tencuahang?.mota}",style: TextStyle(fontSize: 16),) ,)


                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left:8),
                      child: Column(

                        children: [
                          Container(
                            alignment: Alignment.centerLeft,

                            child: Text("Giờ mở cửa",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("8h-22h",style: TextStyle(fontSize: 16),),),

                          Divider(
                            color: Colors.black.withOpacity(0.2),
                          ),


                        ],
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 4),


                      child: Column(
                        children: [
                          Container(


                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 12,right: 12),
                            child: Column(

                              children: [
                                Row(
                                  children: [
                                    Container(

                                        padding: EdgeInsets.all(5)
                                        ,

                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            border: Border.all(color: Colors.black.withOpacity(0.2)),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Icon(Icons.location_on,size: 20,)),
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: Container(margin: EdgeInsets.only(top: 10),
                                        child: Text("${widget.tencuahang!.diachi}",style: TextStyle(fontSize: 16),),),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                Row(
                                  children: [
                                    Container(

                                        padding: EdgeInsets.all(5)
                                        ,

                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            border: Border.all(color: Colors.black.withOpacity(0.2)),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Icon(Icons.coffee,size: 20,)),
                                    SizedBox(width: 20,),
                                    Container(margin: EdgeInsets.only(top: 10),
                                      child: Text("Phục vụ tại cổ",style: TextStyle(fontSize: 16),),),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                Row(
                                  children: [
                                    Container(

                                        padding: EdgeInsets.all(5)
                                        ,

                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            border: Border.all(color: Colors.black.withOpacity(0.2)),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Icon(Icons.shopping_cart,size: 20,)),
                                    SizedBox(width: 20,),
                                    Container(margin: EdgeInsets.only(top: 10),
                                      child: Text("Mua mang đi",style: TextStyle(fontSize: 16),),),
                                  ],
                                )



                              ],
                            ),
                          ),
                          Divider(color: Colors.black.withOpacity(0.2),),
                          Container(
                            height: 300,
                            child: FlutterMap(options: MapOptions(
                                initialCenter:
                                LatLng(widget.tencuahang!.lattidude!,widget.tencuahang!.longatitude!),
                                initialZoom:16

                            ), children:[
                              // TileLayer(
                              //   urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              //   subdomains: ['a', 'b', 'c'],
                              // ),

                              TileLayer(
                                urlTemplate: "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
                                subdomains: ['a', 'b', 'c'],

                              ),
                              MarkerLayer(markers: [
                                Marker(

                                    point:LatLng(widget.tencuahang!.lattidude!,widget.tencuahang!.longatitude!),

                                    child: Icon(Icons.location_on,color: Colors.red,))

                              ])
                            ]),
                          ),
                          SizedBox(height: 5,),
                          InkWell(
                            onTap: (){

                              context.read<order_provider>().setStore(widget.tencuahang!);

                              SnackBar a = SnackBar(content: Text(" đã chọn cửa hàng ở địa chỉ ${widget.tencuahang!.diachi} làm vị trí đặt hàng"));
                              ScaffoldMessenger.of(context).showSnackBar(a ) ;
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                 // color: Colors.orangeAccent
                              ),
                              child:
                              Text("Sữ dụng địa chỉ để đặt hàng",style: TextStyle(color: Colors.black),),
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MapDirection(item:widget.tencuahang )));

                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orangeAccent
                              ),
                              child:
                              Text("Chỉ đường đến quán",style: TextStyle(color: Colors.white),),
                            ),
                          )








                        ],
                      ),
                    )
                  ]),
                  Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close_outlined,color: Colors.white,),
                    ),
                  ),
            ]


          ),
        )




      ));
    }
  }
