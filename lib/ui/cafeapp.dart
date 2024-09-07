import 'package:caffeapp/provider/cart.dart';
import 'package:caffeapp/provider/detail_drink.dart';
import 'package:caffeapp/provider/order_provider.dart';
import 'package:caffeapp/provider/shipper.dart';
import 'package:caffeapp/provider/shipper_provider.dart';
import 'package:caffeapp/provider/user_provider.dart';
import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/ui/admin_screen/admin_function/firebase_Utils.dart';
import 'package:caffeapp/ui/main_screen/Screen_Carts/carttabs..dart';
import 'package:caffeapp/ui/main_screen/Screen_Login/signintabs.dart';
import 'package:caffeapp/ui/main_screen/Sreen_Store/storesingle.dart';
import 'package:caffeapp/ui/main_screen/Sreen_Store/storetabs.dart';
import 'package:caffeapp/ui/main_screen/Screen_Notifi/notifitabs.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';


import '../provider/statusOrder.dart';
import 'main_screen/Screen_Orther/info_screen.dart';
import 'main_screen/Screen_Home/bottom_bar_main.dart';
class cafffeapphome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context){return getData();}),
        ChangeNotifierProvider(create: (BuildContext context){return user_provider();}),
        ChangeNotifierProvider(create: (BuildContext context){ return DetailDrinkProvider();}),
        ChangeNotifierProvider(create: (BuildContext context){ return cart();}),
        ChangeNotifierProvider(create: (BuildContext context ){return shipper();}),
        ChangeNotifierProvider(create: (BuildContext context){return order_provider();}),
        ChangeNotifierProvider(create: (BuildContext context){return firebase_Utils();}),
        ChangeNotifierProvider(create: (BuildContext context){return shipper_provider();}),
        ChangeNotifierProvider(create: (BuildContext context) {return statusOrder();})
      ],
      child: MaterialApp(
      // home: singinTabs(),

        home: caffeapp(currentPage: NavigationPages.home,),
        //home:storetabs(),
        // home:caffeapp(currentPage: NavigationPages.bloc,),
        debugShowCheckedModeBanner: false
        ,
      ),
    );
  }
}




class caffeapp extends StatefulWidget {
  caffeapp({super.key, required this.currentPage});
  final NavigationPages currentPage;

  @override
  State<caffeapp> createState() => _caffeappState();
}


class _caffeappState extends State<caffeapp> {
  int _currentNavigationIndex = 0;
  Color colorItem = const Color(0xffC4671A);

  final double _paddingHeight = 5;
  final double _paddingHeightImage = 6.5;
  final double _fontSize = 9;
  final double _iconSize = 20;
  late List<Widget> _pages;

  @override
  void initState() {
    // context.watch()<getData>().getList();
    // context.watch()<getData>().getCuaHangListFromFirestore();
    //
    // context.watch()<getData>().getOrders();
    if(context.read<getData>().listcaffe.isEmpty){
      context.read<getData>().initStreams();
    }
    super.initState();
    _currentNavigationIndex = widget.currentPage.index;

    _pages = [
      hometabpage()

      ,  storetabs()
      ,  carttabs()
      ,   infor_screen()
      ,
    ];



  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(


      body: buildBody(),
      bottomNavigationBar: buidBottomBar(),),
    );
  }


  Widget buildBody() {
    return Stack(
      children: [
        Container(



            padding: const EdgeInsets.only(top: 0, bottom: 0),
            child: _pages[_currentNavigationIndex]
        ),



      ],
    );
  }

  CurvedNavigationBar buidBottomBar(){
    return  CurvedNavigationBar(
      height: 50,
    index: _currentNavigationIndex,
    backgroundColor: Colors.white,
    color: Colors.orangeAccent,
    buttonBackgroundColor: Colors.orangeAccent,
    animationDuration: Duration(milliseconds: 400),
      items: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.home_outlined, size: 15, color: Colors.white),

            Text("Home", style: TextStyle(fontSize: 10,color: Colors.white)),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.store_mall_directory_outlined, size: 15, color: Colors.white),

            Text("Store", style: TextStyle(fontSize: 10,color: Colors.white)),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.shopping_cart_outlined, size: 15, color: Colors.white),

            Text("Product", style: TextStyle(fontSize: 10,color: Colors.white)),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.menu, size: 15, color: Colors.white),

            Text("Orther", style: TextStyle(fontSize: 10,color: Colors.white)),
          ],
        ),
      ],

      onTap: onTapNavigationBar,
    );

  }
  void onTapNavigationBar(int value) {
    switch(NavigationPages.values[value]){
      case NavigationPages.home:
        _changePages(value);
        break;
      case NavigationPages.bloc:
        _changePages(value);
        break;
      case NavigationPages.store:
        _changePages(value);
        break;
      case NavigationPages.carts:
        _changePages(value);
        break;



    }
  }

  void _changePages(int value) {
    setState(() {
      _currentNavigationIndex = value;
    });
  }

}



enum NavigationPages{
  home,
  store,
  carts,
  bloc,

}








// class hometab extends StatelessWidget {
//   const hometab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  SafeArea(child: Scaffold(
//
//
//       body: hometabpage(),
//
//
//     )
//     );
//   }
// }




