import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class singledisscount extends StatefulWidget {
  const singledisscount({super.key});

  @override
  State<singledisscount> createState() => _singledisscountState();
}

class _singledisscountState extends State<singledisscount> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 12,left: 12),
          child: Stack(
            children: [
              Column(
              children: [
                Image.asset("images/discount1.jpg",height: 400,width: 400,
                fit: BoxFit.fill,),
                SizedBox(height: 10,),
                Text("TRÀ XANH TÂY BẮC, NHÀ MỜI DEAL MUA 1 TẶNG 1",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("Ngày hối hả, Nhà mời bạn chút thảnh thơi với Trà Xanh Tây Bắc vị mộc dễ uống, dễ yêu kèm deal Mua 1 Tặng 1 xịn hết nấc. ",style: TextStyle(fontSize: 16),),
                SizedBox(height: 5,),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Thời gian: 08.01 - 10.01 " ,style: TextStyle(fontSize: 16),)),
                Text("Mở app nhập mã: TRAXANH Áp dụng cho đơn Giao hàng Chớp deal, thưởng trà bạn nhé!",style: TextStyle(fontSize: 16),)
              ],


            ),
              InkWell(
                onTap:(){
                  Navigator.pop(context);
                },
                child: Container(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.close,color: Colors.black,)),
              )
                ]
          ),
        ),
      ),
    ));
  }
}
