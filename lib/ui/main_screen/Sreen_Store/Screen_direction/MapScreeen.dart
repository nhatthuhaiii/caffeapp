import 'package:caffeapp/ui/main_screen/Sreen_Store/storesingle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../provider/getData.dart';
import '../../../../src/cuahang.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
   List<cuahang> lst = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lst = context.read<getData>().listcuahang;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Bản đồ  "),),
      body:FlutterMap(
        options:MapOptions(
            initialCenter:
            LatLng(16.0583,105.2772),
            initialZoom: 5.8

        ), children: [
        TileLayer(
          urlTemplate: "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
          subdomains: ['a', 'b', 'c'],

        ),
        MarkerLayer(markers: [
            for(var item in lst)
                Marker(point: LatLng(item.lattidude!,item.longatitude!), child:


                  InkWell(
                      onTap: (){
                        showModalBottomSheet(context: context, isScrollControlled: true,
                            builder: (context)=>FractionallySizedBox(
                          heightFactor: 0.8,
                          child: storesingle(
                             tencuahang: item ,),
                        )
                        );
                      },
                      child: Icon(Icons.coffee,color: Colors.orangeAccent,)),
                )
        ]
        )
      ],

      ),
    ));
  }
}
