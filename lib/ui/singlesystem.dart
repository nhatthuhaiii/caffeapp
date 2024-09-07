import 'package:caffeapp/ui/cafeapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class singlesystem extends StatefulWidget {
  const singlesystem({super.key});

  @override
  State<singlesystem> createState() => _singlesustemState();
}

class _singlesustemState extends State<singlesystem> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            color: Colors.orangeAccent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios)),
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Sản Phẩm Mới",
                      style: TextStyle(fontSize: 18),
                    )
                )
              ],
            ),
          ),
         SingleChildScrollView(
           child: Container(
             margin: EdgeInsets.only(left: 12,right: 12),
             child: Column(
               children: [
                 Image.asset("images/trasua_suongsao.JPG",height: 400,width: 400,fit: BoxFit.fill,),
                 Align(alignment:Alignment.topLeft ,
                   child: Text(
                     "Trà Sữa sương sáo",
                     style: const TextStyle(
                       fontSize: 30,
                       fontWeight: FontWeight.bold,
                       fontStyle: FontStyle.italic,
                       color: Colors.black,
                     ),
                   ),

                 ),

                 Align(
                     alignment: Alignment.topLeft,
                     child: Text("15.000VNĐ",style: TextStyle(fontSize: 20),)),
                 Text("Tận hưởng hương vị Oolong nướng đậm đà được Nhà rang kỹ càng, quyện cùng sữa thơm béo, càng thêm hấp dẫn với sương sáo thanh mát.",style: TextStyle(fontSize: 16),),


               ],
             ),
           ),
         ),
          Expanded(
            child: InkWell(
             onTap: (){
               Navigator.push(context,MaterialPageRoute(builder: (context)=>cafffeapphome()));

             },
              child: Container(
                height: 10,
                width: 200,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.center,

                      child: Text("Đặt hàng ngayy"),
                ),
              ),
            ),
          )

        ],
      ),
    ));
  }
}
