import 'package:caffeapp/provider/cart.dart';
import 'package:caffeapp/provider/user_provider.dart';
import 'package:caffeapp/src/category.dart';
import 'package:caffeapp/src/cuahang.dart';
import 'package:caffeapp/src/detail.dart';
import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/ui/main_screen/Screen_Carts/carttabs..dart';
import 'package:caffeapp/ui/main_screen/Screen_Carts/favorite_Screen.dart';
import 'package:caffeapp/ui/main_screen/Screen_Notifi/notifitabs.dart';
import 'package:caffeapp/ui/main_screen/Screen_search/searchtab.dart';
import 'package:caffeapp/ui/main_screen/Screen_Login/signintabs.dart';
import 'package:caffeapp/ui/main_screen/Screen_Carts/singleitems..dart';
import 'package:caffeapp/ui/main_screen/Sreen_Store/storesingle.dart';
import 'package:caffeapp/ui/main_screen/Sreen_Store/storetabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../provider/detail_drink.dart';
import '../../../src/cafe.dart';

import '../../../src/user.dart';
import '../Screen_Orther/Screen_person/option_person.dart';
import '../Screen_orderProduct/orderdetail.dart';

class hometab extends StatefulWidget {
  const hometab({super.key});

  @override
  State<hometab> createState() => _hometabState();
}

class _hometabState extends State<hometab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hometabpage(),
    );
  }
}

class hometabpage extends StatefulWidget {
  hometabpage({super.key});

  @override
  State<hometabpage> createState() => _hometabpageState();
}


class _hometabpageState extends State<hometabpage> {
  List<Caffe> lst = [];
  List<cuahang> store = [];
  int indexcontrol=0 ;
  bool setting = false;
  List<CategoryList> category = CategoryList.GetListCategory();


  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {

      setState(() {
        indexcontrol = 0;
      });
    });
  }
  @override
  Widget build(BuildContext context) {


    PageController controller = new PageController();
    store = context.read<getData>().listcuahang;
    lst = context.read<getData>().listcaffe;
    void _goToPage(int page) {
      controller.animateToPage(
        page,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    return SafeArea(child:



    Scaffold(
      //backgroundColor: Colors.orangeAccent.withOpacity(0.1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black87.withOpacity(0.6 ),
        elevation: 2,
        title: Selector<user_provider,user?>(
          builder: (BuildContext context, user? value, Widget? child) {
            return Row(

              children: [
               Visibility(
                   visible: value==null?false:true,
                   child: CircleAvatar(

                     backgroundImage:Image.network(
                         "${value?.url}").image,
                   )
               ),
                SizedBox(width: 10,),
                Text("${value != null?"Chào " +value.name.toString()+"!!" :"Chào bạn mới" }"),
              ],
            );

          },
      selector: (BuildContext context ,value ) {
            return value.userinfo;

      },
      ),
        backgroundColor: Colors.white,
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
            child: Icon(Icons.notifications_active_outlined,color: Colors.orangeAccent,size: 30,),
          ),
        )
      ],),
      body: Selector<cart,Tuple3<List<detail>,int,int>>(
        selector: (BuildContext ,value ) {
          return Tuple3(value.lst, value.tong, value.gia);

        }, builder: (BuildContext context, Tuple3<List<detail>, int, int> value, Widget? child) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Divider(
                    //
                    //   color: Colors.black.withOpacity(0.1),
                    //   indent:0.5,
                    // ),
                    SizedBox(height: 3,),

                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),

                      child: ClipRRect(

                        borderRadius:BorderRadius.circular(10),
                        child: ImageSlideshow(
                        autoPlayInterval: 3000,
                        indicatorColor:Colors.blue,
                              indicatorBackgroundColor: Colors.grey.shade200,
                              isLoop: true,
                              children: [
                                Image.asset("images/quangcao4.jpg", fit: BoxFit.fill),
                                Image.asset("images/quangcao5.jpg", fit: BoxFit.fill),
                                Image.asset("images/quangcao1.jpg", fit: BoxFit.fill),
                                Image.asset("images/quangcao2.jpg", fit: BoxFit.fill),


                              ]
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 10),
                      child: Divider(
                        color: Colors.grey,

                      ),
                    ),

                    // Container(
                    //     margin: EdgeInsets.only(left: 10,bottom: 5,),
                    //     child: Text("Chi nhánh mới",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                    // Container(
                    //   margin: EdgeInsets.only(left: 10,right: 8),
                    //   height: 200,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.all(Radius.circular(15)),
                    //     child: ImageSlideshow(
                    //       autoPlayInterval: 3000,
                    //       children: [
                    //         for(var it in store)
                    //               InkWell(
                    //                 onTap: (){
                    //                   showModalBottomSheet(context: context,isScrollControlled: true,builder:(context)=>FractionallySizedBox(
                    //                     heightFactor: 0.9,
                    //                     child: storesingle(tencuahang: it,),
                    //                   ));
                    //                 },
                    //                 child: Container(
                    //                   margin: EdgeInsets.only(right: 5),
                    //                   height: 100,
                    //                   width: 150,
                    //                   child: Image.asset("${it.url}",fit: BoxFit.fill,),
                    //                 ),
                    //               )
                    //
                    //       ],
                    //     ),
                    //   ),
                    //
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 10),
                      child: Divider(
                        color: Colors.grey,

                      ),
                    ),



                      Container(

                          margin: EdgeInsets.only(left: 12,top: 5,bottom: 5),
                          child: Text("Danh mục sản phẩm",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // Màu bóng đổ
                              blurRadius: 2, // Độ mờ thấp để giữ bóng sát viền
                              spreadRadius: 1, // Mở rộng bóng ra viền nhẹ
                              offset: Offset(0, 0), //ộ dịch chuyển (x, y)
                            )],
                        border: Border.all(color: Colors.black.withOpacity(0.2)),
                        color: Colors.white
                      ),
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                  width: 180,
                                  margin: EdgeInsets.only(bottom: 5),

                                  child: TextFormField(
                                    readOnly: true,
                                    onTap: () {
                                      showSearch(context: context, delegate: searchcaffe());
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.orangeAccent.withOpacity(0.3), width: 1),
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      suffixIcon: Icon(Icons.search_outlined, color: Colors.black.withOpacity(0.2)),
                                      hintText: "Tìm kiếm",
                                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                                    ),
                                    style: TextStyle(color: Colors.black87),
                                    cursorColor: Colors.black87,
                                  ),
                                ),
                              ),
                             SizedBox(width: 10,),
                             InkWell(
                                     onTap: (){
                                if(context.read<user_provider>().userinfo == null){
                                  showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>FractionallySizedBox(
                                    heightFactor: 0.9,
                                    child: singinTabs(),
                                  ) );
                                  return;
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> favorite_Screen()));
                             }, child: Icon(Icons.favorite_rounded,color: Colors.red,size: 30,))
                            ],
                          ),


                          Container(

                            height: 100,
                            margin: EdgeInsets.only(bottom: 10),
                            child: GridView.count(
                             // scrollDirection: Axis.horizontal,
                             crossAxisCount: 4  ,
                            //  physics: NeverScrollableScrollPhysics(),
                              children: [
                                for(int index  =0 ; index < category.length;index++)
                                      InkWell
                                      (
                                      onTap: (){
                                      indexcontrol=index;

                                      setState(() {
                                      _goToPage(index);
                                      });

                                      },
                                      child: Container(

                                      width: 70,
                                        margin: const EdgeInsets.only(left: 5, right:5,),

                                      child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [


                                      Image.asset("${category[index].urlImage}",
                                      height: 65,

                                      ),
                                      Expanded(child: Text("${category[index].name}")),
                                      ],
                                      ),
                                      ),
                                      )


                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 550,
                      child: Selector<getData, List<Caffe>>(
                        selector: (_, dataProvider) => dataProvider.listcaffe,
                        builder: (context, coffeeList, _) {
                          return PageView(
                            controller: controller,
                            onPageChanged: (int page) {
                              setState(() {
                                indexcontrol = page;
                              });
                            },
                            children: [
                              for (var it in category)
                                GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  childAspectRatio: MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 1.5),
                                  children: [
                                    for (int i = 0; i < coffeeList.length; i++)
                                      if (coffeeList[i].ten.toLowerCase().contains(it.name!.toLowerCase()))

                                          Selector<DetailDrinkProvider,List<String>>(
                                            builder: (BuildContext context, List<String> value, Widget? child) {
                                              return  Container(
                                                padding: EdgeInsets.only(left: 10,right: 10,top: 5),
                                                margin: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.yellowAccent.withOpacity(0.35)),
                                                  color: Colors.white60.withOpacity(0.7),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 6,
                                                      child: InkWell(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                              context: context,
                                                              isScrollControlled: true,
                                                              builder: (context) {
                                                                bool isfv = value.contains(coffeeList[i].ten);
                                                                return FractionallySizedBox(
                                                                  heightFactor: 0.9,
                                                                  child: singleitems(
                                                                      data: coffeeList[i],fv: isfv),
                                                                );
                                                              });
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(bottom: 5),
                                                          child: Image.network(
                                                            "${coffeeList[i].url}",
                                                            width: 140,
                                                            height: 150,
                                                            fit: BoxFit.fill,
                                                            loadingBuilder: (context, child, loadingProgress) {
                                                              if (loadingProgress == null) {
                                                                return child;
                                                              }
                                                              // Hiển thị placeholder tạm thời trong khi đang tải
                                                              return Stack(
                                                                children: [
                                                                  // Placeholder ảnh mờ mờ
                                                                  Image.asset(
                                                                    "images/brand_logo2.jpg",
                                                                    width: 140,
                                                                    height: 150,
                                                                    fit: BoxFit.fill,
                                                                    color: Colors.black.withOpacity(0.3),
                                                                    colorBlendMode: BlendMode.darken,
                                                                  ),
                                                                  // Vòng tròn loading ở giữa
                                                                  Positioned.fill(
                                                                    child: Center(
                                                                      child: CircularProgressIndicator(
                                                                        value: loadingProgress.expectedTotalBytes != null
                                                                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes!)
                                                                            : null,
                                                                        strokeWidth: 2,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                            errorBuilder: (context, error, stackTrace) {
                                                              return Image.asset(
                                                                "images/brand_logo2.jpg",
                                                                width: 140,
                                                                height: 150,
                                                                fit: BoxFit.fill,
                                                              );
                                                            },
                                                          )
                                                          ,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(top: 5, bottom: 5),
                                                            alignment: Alignment.topLeft,
                                                            child: Text(
                                                              "${coffeeList[i].ten}",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black.withOpacity(0.8),
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(
                                                                  alignment: Alignment.bottomLeft,
                                                                  child: Text(
                                                                    "${coffeeList[i].gia}" + ".000VNĐ",
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w100,
                                                                      color: Colors.black.withOpacity(0.8),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    if(context.read<user_provider>().userinfo == null){
                                                                      showModalBottomSheet(
                                                                          context: context,
                                                                          isScrollControlled: true,
                                                                          builder: (context) => FractionallySizedBox(
                                                                            heightFactor: 0.9,
                                                                            child: singinTabs(),
                                                                          )
                                                                      );
                                                                      return;
                                                                    }

                                                                    detail a = detail(coffeeList[i], 1, "M");
                                                                    context.read<cart>().addItems(a);
                                                                    setState(() {});
                                                                  },
                                                                  child: Container(
                                                                      padding: EdgeInsets.all(5),
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.orange,
                                                                        borderRadius: BorderRadius.circular(20),
                                                                      ),
                                                                      child: Icon(
                                                                        CupertinoIcons.add,
                                                                        color: Colors.white,
                                                                        size: 20,
                                                                      )
                                                                  ),
                                                                ),
                                                              ]
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },

                                            selector: (BuildContext context, DetailDrinkProvider ) {
                                              return DetailDrinkProvider.lstfv;
                                            },

                                          )


                                  ],
                                )
                            ],
                          );
                        },
                      ),
                    )







                  ],
                ),
              ),
              Visibility(
                visible: value.item1.length>0 ,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white60.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                            )
                          ],
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        height:45,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.orange,
                              size: 30,
                            ),
                            Container(
                              height: 40,
                              child: Column(
                                children: [
                                  Text("THE COFFE HOUSE" ,style: TextStyle(fontSize: 12,color: Colors.orange,fontWeight: FontWeight.bold),),
                                  Text("Xem giỏ hàng",style: TextStyle(fontSize: 10,color: Colors.orange),)
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: () {



                                showModalBottomSheet(context: context,
                                    isScrollControlled: true,
                                    builder: (context){

                                      return FractionallySizedBox(
                                        heightFactor: 0.95,
                                        child: orderdetail(),
                                      );
                                    }
                                );


                              },
                              child: Container(

                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(30),

                                ),
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Container(

                                      alignment: Alignment.center,
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color:Colors.white ,
                                          borderRadius: BorderRadius.circular(40)
                                      ),
                                       child: Text(

                                       value.item2.toString(),style: TextStyle(color: Colors.black),
                                    ),
                                    ),
                                    Container(

                                      margin: EdgeInsets.only(right: 8,left: 6),

                                       child:Text(value.item3.toString()+".000VNĐ"),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),



                      )))],
          );


      },),





    ));
  }
}
