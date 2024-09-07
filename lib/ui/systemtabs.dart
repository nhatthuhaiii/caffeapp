import 'package:caffeapp/ui/singlesystem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class systemtabs extends StatefulWidget {
  const systemtabs({super.key});

  @override
  State<systemtabs> createState() => _systemtabsState();
}

class _systemtabsState extends State<systemtabs> {
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
                        onTap:(){Navigator.pop(context);},
                        child: Icon(Icons.arrow_back_ios)),
                    Align(
                      alignment: Alignment.topCenter,
                        child: Text("Thông Báo hệ thống",style: TextStyle(fontSize: 18),))



                  ],

                ),
              ),
              SizedBox(height: 10,),
              Expanded(child: SingleChildScrollView(
                child: Column(children: [
                  for(int i =0 ; i < 10;i++)
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>singlesystem()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 12,top:5,right: 12,bottom: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color:Colors.orangeAccent)),
                        child:Row(
                            children:[

                              Image.asset("images/trasua_suongsao.JPG",height: 80,width: 80,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                        alignment:Alignment.topLeft,



                                        child: Text("Sản phẩm mới cho bạn",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)

                                    ),
                                    Container(
                                        alignment:Alignment.topLeft,
                                        child: Text("Sản phẩm mới đời vui phơi phới"))
                                  ],
                                ),
                              )

                            ]
                        ),


                      ),
                    )
                ],),
              ))

,



            ],


          ),



    )
    );
  }
}
