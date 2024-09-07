import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/provider/shipper.dart';
import 'package:caffeapp/provider/shipper_provider.dart';
import 'package:caffeapp/provider/user_provider.dart';
import 'package:caffeapp/src/shipper.dart';

import 'package:caffeapp/ui/main_screen/Screen_Login/registerTabs.dart';
import 'package:caffeapp/ui/shipper_screen/shipper_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/detail_drink.dart';
import '../../../src/user.dart';
import '../../../src/user.dart';
import '../../admin_screen/admin_screen.dart';

class singinTabs extends StatefulWidget {
   singinTabs({super.key});

  @override
  State<singinTabs> createState() => _singinTabsState();
}

class _singinTabsState extends State<singinTabs> {
  late String account="admin";
  late String pass="admin";
   List<user>? lst=[];
  @override
 void initState() {
    // TODO: implement initState

    super.initState();

  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset("images/quangcao1.jpg",height: 200, fit: BoxFit.fill,),
          
              Container(
                margin: EdgeInsets.only(top: 180),
                padding: EdgeInsets.only(left: 12,right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
               //   borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20)),
                  borderRadius:BorderRadius.vertical(
                    top:Radius.circular(30)
                  )
                ),
                child: Column(
                  children: [
                        SizedBox(height: 20,),
                        Center(child:Text("Chào mừng bạn đến với ",style: TextStyle(color: Colors.black,fontSize: 14,decoration: TextDecoration.none),)),
                    SizedBox(height: 15,),
                         Center(child:Text("THE COFFE HOUSE ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,decoration: TextDecoration.none),)),
                    SizedBox(height: 20,),
          
                    Container(
                      padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black.withOpacity(0.5))
                    ),
                    child: TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
          
                        onChanged: (value1) {
                            this.account = value1;
                        },
                        decoration: InputDecoration(
                          hintText: "Tài khoản",
                         icon: Icon(Icons.person,color: Colors.orange,),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8)),
                        )),
                  ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black.withOpacity(0.5))
                      ),
                      child: TextFormField(
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          obscuringCharacter: "*",
                          obscureText: true,
                          onChanged: (value) {
                            this.pass = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Mật khẩu",
                            icon: Icon(Icons.key_outlined,color: Colors.orange,),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.8)),
                          )
                      ),
          
          
                    ),
                    SizedBox(height: 10,),
          
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => registerTabs() ));
          
                        },
                        child: Text("Đăng ký", style: TextStyle(color: Colors.blue,fontSize: 14),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap:() async {
                        if(account=="admin"&& pass=="admin"){

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>admin_screen(currentPage: NavigationPages.admin_products) ));
                          return;
                        }

                        if(account.contains("shipper")){

                         var  a =  await context.read<shipper_provider>().shipperLoginFireBase(account, pass) ;
                          if(a!=null){

                              Navigator.push(context,MaterialPageRoute(builder: (context)=>screen_shipper()));
                              return;

                          }






                        }


                        var user = context.read<user_provider>().loginUserFireBase(account, pass);

                        if (user != null) {

                        Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                  "Tài khoản hoặc mật khẩu không đúng"))
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.orange
                        ,
                          borderRadius:BorderRadius.circular(10),
          
                        ),
          
                        child: Center(child: Text("Đăng nhập",style: TextStyle(color: Colors.white),)),
          
                      ),
                    )
          
          
          
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
