import 'package:caffeapp/provider/detail_drink.dart';
import 'package:caffeapp/src/detail.dart';
import 'package:caffeapp/ui/main_screen/Screen_Orther/Screen_person/option_person.dart';
import 'package:caffeapp/ui/main_screen/Screen_Orther/Screen_policy/policy_screen.dart';
import 'package:caffeapp/ui/main_screen/Screen_Login/signintabs.dart';
import 'package:caffeapp/ui/main_screen/Screen_Orther/screen_fb/screen_fb.dart';
import 'package:caffeapp/ui/main_screen/Screen_Orther/screen_vnpay_policy/vnpay_screen.dart';
import 'package:caffeapp/ui/main_screen/Screen_Orther/screen_website/screen_website.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/cart.dart';
import '../../../provider/user_provider.dart';
import '../Screen_Notifi/notifitabs.dart';

class infor_screen extends StatefulWidget {
  const infor_screen({super.key});

  @override
  State<infor_screen> createState() => infor_screenState();
}

class infor_screenState extends State<infor_screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:

    Scaffold(
      appBar: AppBar(title: Text("Khác"),
        automaticallyImplyLeading: false,
        shadowColor: Colors.black87.withOpacity(0.6 ),
        elevation: 2,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 12),
          child: InkWell(
            onTap: (){
              if(context.read<user_provider>().userinfo== null){
                showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>FractionallySizedBox(
                  heightFactor: 0.9,
                  child: singinTabs(),
                ) );
                return;

              }

              Navigator.push(context, MaterialPageRoute(builder: (context)=> notifitabs()));
            },
            child: Icon(Icons.notifications_active_outlined,color: Colors.black87,size: 30,),
          ),
        )

      ],),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 12,right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
                Container(
                  child:Text("Tiện ích",style: TextStyle(fontSize: 20),)
                  ,
        
        
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(context.read<user_provider>().userinfo == null){
                              showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>
                                  FractionallySizedBox(
                                    heightFactor: 0.8,
                                    child: singinTabs(),
                              ));
                              return;
                          }
        
        
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> notifitabs()));
                        },
                        child: Container(
                          padding:EdgeInsets.only(left: 10),
                          decoration:BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.2)),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3),spreadRadius: 1,blurRadius: 1,offset: Offset(1,1))],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.menu,color: Colors.orangeAccent,),
                              SizedBox(height: 10,),
                              Text("Lịch sử đơn hàng",style: TextStyle(fontSize: 18))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> policy_screen ()));
                        },
                        child: Container(
                        padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.2)),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3),spreadRadius: 1,blurRadius: 1,offset: Offset(1,1))],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.menu,color: Colors.purple,),
                              SizedBox(height: 10,),
                              Text("Điều khoản",style: TextStyle(fontSize: 16))
                            ],
                          ),
                        ),
                      ),
                    )
        
                  ],
                ),
              InkWell(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>vnpay_screen()));},
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3),spreadRadius: 1,blurRadius: 1,offset: Offset(1,1))],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,),
                  child: Row(

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.menu_open,color: Colors.red,),
                          Text("Điều khoản VNPAY",style: TextStyle(fontSize: 16),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,
              ),
              Text("Liên hệ với chúng tôi",style: TextStyle(fontSize: 20),),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text("Hotline",style: TextStyle(fontSize: 18),),
                        Text("18006836",style: TextStyle(fontSize: 18),)
                      ],)
                    ],
                  ),
                  Divider(color:Colors.black.withOpacity(0.3)),
                  Row(
                    children: [
                      Icon(Icons.mail_outline),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",style: TextStyle(fontSize: 18),),
                          Text("hi@thecoffeehouse.vn",style: TextStyle(fontSize: 18),)
                        ],)
                    ],
                  ),
                  Divider(color:Colors.black.withOpacity(0.3)),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>screen_website()));

                    },
                    child: Row(
                      children: [
                        Icon(Icons.language_outlined),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Website",style: TextStyle(fontSize: 18),),
                            Text("www.thecoffeehouse.com",style: TextStyle(fontSize: 18),)
                          ],)
                      ],
                    ),
                  ),
                  Divider(color:Colors.black.withOpacity(0.3)),
                  InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>screen_fb()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.facebook_outlined),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Facebook",style: TextStyle(fontSize: 18),),
                            Text("facebook.com/The.Coffe.House.2014",style: TextStyle(fontSize: 18),)
                          ],)
                      ],
                    ),
                  )
        
        
                ],
              ),
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
              SizedBox(height: 10,),
              Text("Tài Khoản",style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3),spreadRadius: 1,blurRadius: 1,offset: Offset(1,1))],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        if(context.read<user_provider>().userinfo== null){
                          showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>FractionallySizedBox(
                            heightFactor: 0.9,
                            child: singinTabs(),
                          ) );
                          return;
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> option_person(data: context.read<user_provider>().userinfo)));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(height: 10,),
                          Text("Thông tin cá nhân",style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10),
                    child: Divider(color: Colors.black.withOpacity(0.3),)),
                    InkWell(
                      onTap: (){
                        context.read<user_provider>().clear();
                        context.read<DetailDrinkProvider>().clear();
                        context.read<cart>().clear();
                        SnackBar s = SnackBar(content: Text("Bạn đã đăng xuất "));
                        ScaffoldMessenger.of(context).showSnackBar(s);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios_new),
                          SizedBox(height: 10,),
                          Text("Đăng xuất",style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    )
        
        
                  ]
                ),
              )
        
        
            ],
        
          ),
        ),
      ),


    ));
  }
}
