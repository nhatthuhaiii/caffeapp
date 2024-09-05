import 'package:caffeapp/ui/searchtabstore.dart';
import 'package:caffeapp/ui/storesingle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/cuahang.dart';

class storetabs extends StatelessWidget {


  List<cuahang> lst = cuahang.getList();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10,left: 12),
                child: Row(
                  children: [
                    Icon(Icons.home_outlined,size: 30,),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 5),
                      child: Text("Cửa hàng" , style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8)),),),
                  ],
                ),
              ),

              Container(
                  padding: EdgeInsets.only(left:5),
                  margin: EdgeInsets.only(left: 12,right: 12,top:5),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellowAccent.withOpacity(0.3)),
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10)),

                  child: TextFormField(
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tìm Kiếm Quán",
                      hintStyle: TextStyle(color:Colors.black.withOpacity(0.3)),

                      suffixIcon: Icon(Icons.search,color:Colors.black.withOpacity(0.3),),

                    ),
                    // tim kiem
                    onChanged: (value) {
                      showSearch(context: context, delegate:searchtabstore());
                    },
                  )
              ),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.topLeft,
                margin:EdgeInsets.only(left: 12) ,
                child: Text("Các Cửa Hàng Khác ",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8)),),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                     
                
                
                    for(int i =0 ; i< lst.length;i++)
                
                        Container(
                          child: Column(
                
                              children: [
                                InkWell(
                                  onTap: (
                
                                      ){
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return FractionallySizedBox(
                                            heightFactor: 0.9,
                                            child: storesingle(tencuahang: lst[i],),
                                          );
                                        });
                
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white60,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.yellowAccent.withOpacity(0.35))

                                      ),
                                      margin: EdgeInsets.only(left: 12,right: 12),
                                      child:Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10,right: 10),
                                            child: Image.asset("${lst[i].url}",height: 100,width: 100,),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child:Text("COFFE HOME",style: TextStyle(
                                                      fontSize:10,
                                                      color: Colors.black
                                                  ),),
                                                ),
                                                SizedBox(height: 10,),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text("${lst[i].diachi}"),)
                                              ],
                                            ),
                                          ),
                                        ],
                
                                      )),
                                ),
                                SizedBox(height: 10,),
                              ]
                          ),
                
                                         ),
                
                
                
                
                
                
                
                
                
                
                    ],),
                ),
              ),
            ],
          ),


        ));
  }
}

