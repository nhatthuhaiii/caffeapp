import 'package:caffeapp/provider/cart.dart';
import 'package:caffeapp/provider/detail_drink.dart';
import 'package:caffeapp/provider/shipper.dart';
import 'package:caffeapp/ui/carttabs..dart';
import 'package:caffeapp/ui/storetabs.dart';
import 'package:caffeapp/ui/notifitabs.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'bottom_bar_main.dart';
class cafffeapphome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context){ return DetailDrinkProvider();}),
        ChangeNotifierProvider(create: (BuildContext context){ return cart();}),
        ChangeNotifierProvider(create: (BuildContext context ){return shipper();})
      ],
      child: MaterialApp(
        home: caffeapp(currentPage: NavigationPages.home,),
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
    super.initState();
    _currentNavigationIndex = widget.currentPage.index;

    _pages = [
      hometabpage()
      ,  storetabs()
      ,  carttabs()
      ,  notifitabs()
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


  // final List<Widget> _tab =[
  //   const hometab(),
  //   storetabs(),
  //   carttabs(),
  //   const notifitabs(),
  // ];
  Widget buildBody() {
    return Stack(
      children: [
        Container(



            padding: const EdgeInsets.only(top: 0, bottom: 0),
            child: _pages[_currentNavigationIndex]
        ),


        // InkWell(
        //   onTap: (){
        //     lst.add("abc");
        //     print("abc");
        //   },
        //   child: Align(
        //
        //     alignment: Alignment.bottomCenter,
        //   child:Container(
        //     height:300,
        //     width:300,
        //     color: Colors.yellow,child: Text("abc"),) ,),
        // )
      ],
    );
  }

  BottomNavigationBar buidBottomBar(){
    return BottomNavigationBar(iconSize: _iconSize,
      currentIndex: _currentNavigationIndex,
      selectedLabelStyle: TextStyle(fontSize: _fontSize, ),
      unselectedLabelStyle: TextStyle(fontSize: _fontSize, color: Colors.grey),
      selectedItemColor: colorItem,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined, color:Colors.black45,),label: "Trang chủ", ),
      BottomNavigationBarItem(icon: Icon(Icons.store_mall_directory_outlined,color: Colors.black45),label: "Cửa hàng"),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined, color: Colors.black45,),label: "Sản phẩm"),
      BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined,color: Colors.black45),label: "Thông báo"),
      ],
      onTap: onTapNavigationBar,);
  }
  void onTapNavigationBar(int value) {
    switch(NavigationPages.values[value]){
      case NavigationPages.home:
        _changePages(value);
        break;
      case NavigationPages.store:
        _changePages(value);
        break;
      case NavigationPages.carts:
        _changePages(value);
        break;

      case NavigationPages.notifi:
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
  notifi,
}








class hometab extends StatelessWidget {
  const hometab({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(


      body: hometabpage(),


    )
    );
  }
}




