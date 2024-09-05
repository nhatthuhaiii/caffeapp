import 'package:caffeapp/provider/detail_drink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/cuahang.dart';

class storesingle extends StatefulWidget {
   storesingle( {super.key,this.tencuahang});
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Stack(
                    children: [
                      Container(
                          color: Colors.green,
                          alignment: Alignment.center,
                          height: heigt/2,
                          width:width ,
                          child:
                          Image.asset(


                            "${widget.tencuahang?.url}",

                            fit: BoxFit.fill,
                            height:MediaQuery.of(context).size.height ,
                            width:MediaQuery.of(context).size.width ,
                          )
                      ),
                      InkWell(
                        onTap: (){Navigator.pop(context);
                        context.read<DetailDrinkProvider>().clear();},
                        child: Ink(
                          child: Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(right: 10,top: 10),
                              child: Icon(Icons.close,color: Colors.white,size: 20,)),
                        ),
                      )
                    ],
                  ),
                  Column(

                    children: [

                      SizedBox(height: 10,),
                      Row(
                        children: [


                          Expanded(
                            flex:2 ,
                            child: Container(
                              padding: EdgeInsets.only(left: 8),

                              child: Text("${widget.tencuahang?.diachi}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,


                                ),),),
                          ),
                          Expanded(child: Selector<DetailDrinkProvider,bool>(
                            selector: (BuildContext, value ) { return value.fv; },
                            builder: (BuildContext context, value, Widget? child) {
                              return Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 8),

                                child: InkWell(
                                    onTap: (){
                                      context.read<DetailDrinkProvider>().clickfv();
                                    },
                                    child: Icon( value? Icons.favorite:Icons.favorite_border,size: 30,color: value? Colors.green:Colors.green)
                                ),
                              );
                            },


                          )),
                        ],

                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8,right: 8,top: 10),
                        child: Text("${widget.tencuahang?.mota}",style: TextStyle(fontSize: 16),) ,)


                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left:8,top: 8),
                    child: Column(

                      children: [
                        Row(
                          children: [

                            Container(
                              child: Text("Giờ mở cửa",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("${widget.tencuahang?.giomocua}",style: TextStyle(fontSize: 16),),)
                      ],
                    ),

                  ),
                  Column(
                    children: [
                      Container(
                        height: 80,

                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 12,right: 12),
                        child: Wrap(

                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 8,top: 10),
                                child: Icon(Icons.car_crash_outlined,size: 20,)),
                            Container(margin: EdgeInsets.only(top: 10),
                              child: Text("${widget.tencuahang?.xeoto}",style: TextStyle(fontSize: 16),),),
                            SizedBox(width: 20,),
                            Container(
                                margin: EdgeInsets.only(left: 8,top: 10),
                                child: Icon(Icons.store_mall_directory_outlined,size: 20,)),
                            Container(margin: EdgeInsets.only(top: 10,left: 8),
                              child: Text("${widget.tencuahang?.taicho}",style: TextStyle(fontSize: 16),),),
                            SizedBox(width: 20,),
                            Container(
                                margin: EdgeInsets.only(left: 8,right: 5,top: 10),
                                child: Icon(Icons.shopping_bag_outlined,size: 20,)),
                            Container(margin: EdgeInsets.only(top: 10),
                              child: Text("${widget.tencuahang?.muave
                              }",style: TextStyle(fontSize: 16),),),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 150,

                        margin: EdgeInsets.only(left: 8,right: 8,top: 10),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InkWell(
                              onTap: (){
                                showModalBottomSheet(context: context, builder: (context){
                                  return FractionallySizedBox(
                                    heightFactor: 0.9,
                                    child: Stack(
                                        children: [Container(
                                          child: Image.asset("${widget.tencuahang?.qc1}",
                                            fit: BoxFit.fill,
                                            height: 1000,
                                            width: 1000,
                                          ),
                                        ),
                                          InkWell(
                                            onTap:(){
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 8),
                                              alignment: Alignment.topRight,
                                              child: Icon(Icons.close,color: Colors.white,),

                                            ),
                                          )
                                        ]),
                                  );

                                });
                              },
                              child: Container(child: Image.asset("${widget.tencuahang?.qc1}"),
                                height: 150,width: 150,),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              onTap: (){
                                showModalBottomSheet(context: context, builder: (context){
                                  return FractionallySizedBox(
                                    heightFactor: 0.9,
                                    child: Stack(
                                        children: [Container(
                                          child: Image.asset("${widget.tencuahang?.qc1}",
                                            fit: BoxFit.fill,
                                            height: 1000,
                                            width: 1000,
                                          ),
                                        ),
                                          InkWell(
                                            onTap:(){
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 8),
                                              alignment: Alignment.topRight,
                                              child: Icon(Icons.close,color: Colors.white,),

                                            ),
                                          )
                                        ]),
                                  );

                                });
                              },
                              child: Container(child: Image.asset("${widget.tencuahang?.qc2}"),
                                height: 150,width: 150,),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              onTap: (){
                                showModalBottomSheet(context: context, builder: (context){
                                  return FractionallySizedBox(
                                    heightFactor: 0.9,
                                    child: Stack(
                                        children: [Container(
                                          child: Image.asset("${widget.tencuahang?.qc1}",
                                            fit: BoxFit.fill,
                                            height: 1000,
                                            width: 1000,
                                          ),
                                        ),
                                          InkWell(
                                            onTap:(){
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 8),
                                              alignment: Alignment.topRight,
                                              child: Icon(Icons.close,color: Colors.white,),

                                            ),
                                          )
                                        ]),
                                  );

                                });
                              },
                              child: Container(child: Image.asset("${widget.tencuahang?.qc3}"),
                                height: 150,width: 150,),
                            )


                          ],),
                      )







                ],
              )
        ]),
      )




    ));
  }
}
