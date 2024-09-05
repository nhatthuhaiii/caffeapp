import 'package:caffeapp/src/cafe.dart';
import 'package:caffeapp/src/detail.dart';
import 'package:caffeapp/ui/singleitems..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../src/cuahang.dart';
import '../provider/cart.dart';


class searchcaffe extends SearchDelegate{
  searchcaffe({String hintText = "Tìm Kiếm",}):super(searchFieldLabel: hintText);
  @override
  List<caffe> lstsearch = caffe.getList();

  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(
          margin: EdgeInsets.only(left: 12),
          child: IconButton(onPressed: (){query=" ";}, icon: Icon(Icons.close,color: Colors.black.withOpacity(0.7),size: 28,)))
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
  List<caffe> lstsugestion =[];
  for(var item in lstsearch){
    if(item.ten!.toLowerCase().contains(query.toLowerCase()))
        lstsugestion.add(item);

  }

  return  ListView.builder(
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
                  child: singleitems(
                    data: rs,
                  ),
                );
              });
        },
        child: Container(
          margin:
          EdgeInsets.only(left: 12, top: 10, right: 12),
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
                margin: const EdgeInsets.only(
                    left: 8, top: 8, bottom: 8),
                child: Image.asset(
                  "${rs.url}",
                  height: 100,
                  width: 100,
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

                        child: Text("${rs.ten}"),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(

                            child:
                            Text("${rs.gia}" + ".000VNĐ"),
                          ),

                          Container(
                            height: 30,
                            width: 30,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius:
                                BorderRadius.circular(
                                    20)),
                            child: InkWell(
                              onTap: (){
                                detail x  = new detail(rs, 1,"M");
                                  context.read<cart>().addItems(x);
                                  Navigator.pop(context);

                              },
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      }



  );
}
}