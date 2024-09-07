

import 'package:caffeapp/src/detail.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/cart.dart';

class screenupdate extends StatefulWidget {
  screenupdate({super.key,required this.data});
  detail data ;

  @override
  State<screenupdate> createState() => _screenupdateState();
}


class _screenupdateState extends State<screenupdate> {
  int slupdate=0;
  String sizeupdate="";
  List<String> lst = ["S", "M" ,"L"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slupdate=widget.data.sl;
    sizeupdate=widget.data.size;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("${widget.data.a.ten}"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10,left: 12,right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("Tên : ${widget.data.a.ten}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    // Text("Giá : ${widget.data.a.gia}",style: TextStyle(fontSize: 14),)
                  ],
                )
              ],
            ),
            Text("Số Lượng sản phẩm:"),
            SizedBox(
              height: 30, width:30,child:

            TextFormField(

              decoration: InputDecoration(
                hintText: widget.data.sl.toString(),

              ),
              onChanged: (value){
                if(value.isEmpty||value==null){
                  slupdate = widget.data.sl ;
                }
                else
                {slupdate = int.parse(value);}
              },
            ),
              ),
            Text("Size: "),
            Container(
              margin: EdgeInsets.only(left: 12,right: 12),
              child: DropdownButton<String>(
                value: sizeupdate,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                items: lst.map(buidMenu).toList(),
                onChanged: (value) =>
                    setState(() => this.sizeupdate = value!),
              ),
            ),



            Spacer(),

            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        detail x = widget.data;
                        x.sl = slupdate;
                        x.size = sizeupdate;
                        context.read<cart>().capnhat(x);
                        Navigator.pop(context);


                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(

                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)
                        ),



                        child: Center(child: Text("xác nhận",style: TextStyle(fontSize: 16,color: Colors.white),)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(color: Colors.red,borderRadius:  BorderRadius.circular(10)),
                        child: Center(child: Text("huỷ",style: TextStyle(fontSize: 15,color: Colors.white),)),),
                    ),
                  )

                ],
              ),
            )

          ],



        ),
      ),


    ));
  }
  DropdownMenuItem<String> buidMenu(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
}



