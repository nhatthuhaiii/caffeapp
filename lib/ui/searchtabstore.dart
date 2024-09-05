import 'package:caffeapp/src/cafe.dart';
import 'package:caffeapp/ui/singleitems..dart';
import 'package:caffeapp/ui/storesingle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/detail_drink.dart';
import '../src/cuahang.dart';


class searchtabstore extends SearchDelegate{
  searchtabstore({String hintText = "Tìm Kiếm",}):super(searchFieldLabel: hintText);
  @override
  List<cuahang> lstsearch = cuahang.getList();
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(
          margin: EdgeInsets.only(left: 12),
          child: IconButton(onPressed: (){query=" ";}, icon: Icon(Icons.close,color: Colors.black.withOpacity(0.7),size:28,)))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return Container(
        margin: EdgeInsets.only(right: 12),
        child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black.withOpacity(0.7),size: 28,)));


  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    double heigt = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<cuahang> lstsugestion =[];
    for(var item in lstsearch){
      if(item.diachi!.toLowerCase().contains(query.toLowerCase()))
        lstsugestion.add(item);

    }

    return  Container(
      margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
          itemCount: lstsugestion.length,
          itemBuilder: (context,index){
            var  rs =lstsugestion[index];
            return  InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.9,
                        child: storesingle(tencuahang: rs,)
                      );
                    });
              },
              child: Container(
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
                                  child: storesingle(tencuahang: rs,),
                                );
                              });

                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.yellowAccent)

                            ),
                            margin: EdgeInsets.only(left: 12,right: 12),
                            child:Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10,right: 10),
                                  child: Image.asset("${rs.url}",height: 100,width: 100,),
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
                                        child: Text("${rs.diachi}"),)
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
            );
          }



      ),
    );
  }
}