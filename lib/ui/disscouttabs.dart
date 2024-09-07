import 'package:caffeapp/ui/singledisscount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class disscouttabs extends StatefulWidget {
  const disscouttabs({super.key});

  @override
  State<disscouttabs> createState() => _disscouttabsState();
}

class _disscouttabsState extends State<disscouttabs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:  Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.orangeAccent,
                  child: Row(
                   //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap:(){Navigator.pop(context);},
                          child: Icon(Icons.arrow_back_ios)),
                      Center(child: Text("Thông báo khuyến mãi",style: TextStyle(fontSize: 18),))



                    ],

                  ),
                ),
                SizedBox(height: 10,),
               Expanded(child: SingleChildScrollView(child: Column(children: [
                 for(int i =0;i <10;i++)
                   InkWell(
                     onTap: (){
                       showModalBottomSheet(context: context,
                           isScrollControlled: true,

                           builder: (context)=>FractionallySizedBox(

                             heightFactor: 0.9,

                             child: singledisscount(),

                           ));
                     },
                     child: Container(
                       margin: EdgeInsets.only(left: 12,top:5,right: 12,bottom: 5),
                       padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           border: Border.all(color:Colors.orangeAccent)),
                       child:Row(
                           children:[

                             Image.asset("images/discount1.jpg",height: 80,width: 80,),
                             SizedBox(width: 10,),
                             Expanded(
                               child: Column(
                                 children: [
                                   Container(
                                       alignment:Alignment.topLeft,



                                       child: Text("Khuyến mãi mới cho bạn",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)

                                   ),
                                   Container(
                                       alignment:Alignment.topLeft,
                                       child: Text("TRÀ XANH TÂY BẮC, NHÀ MỜI DEAL MUA 1 TẶNG 1"))
                                 ],
                               ),
                             )

                           ]
                       ),


                     ),
                   )

               ],),))





              ],


            ),
          ),



        );

  }
}
