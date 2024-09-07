import 'package:caffeapp/ui/admin_screen/admin_discount_screen/admin_discount_screen.dart';
import 'package:caffeapp/ui/admin_screen/admin_home_screen/admin_home_screen.dart';
import 'package:caffeapp/ui/admin_screen/admin_orderdetail_screen/admin_orderDetail_screen.dart';
import 'package:caffeapp/ui/admin_screen/admin_products_screen/admin_products_screen.dart';
import 'package:caffeapp/ui/admin_screen/admin_store_screen/admin_store_screen.dart';
import 'package:caffeapp/ui/cafeapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class admin extends StatelessWidget {
  const admin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: admin_screen(currentPage: NavigationPages.admin_orderDetail,),

    );
  }
}





class admin_screen extends StatefulWidget {
  admin_screen({super.key,required this.currentPage});
  final NavigationPages currentPage;

  @override
  State<admin_screen> createState() => _admin_screenState();
}

class _admin_screenState extends State<admin_screen> {
  int _currentNavigationIndex = 0;
  final double _fontSize = 9;
  Color colorItem = const Color(0xffC4671A);
  final double _iconSize = 20;
  late List<Widget> _pages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentNavigationIndex = widget.currentPage.index;

    _pages = [

      admin_products_screen(),
      admin_orderDetail_screen(),
      admin_store_screen(),
      admin_discount_screen()


    ];
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: buildBody(),
      bottomNavigationBar: buidBottomBar(),
    ));
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


        BottomNavigationBarItem(icon: Icon(Icons.coffee_outlined,color: Colors.black45),label: "Sản Phẩm"),

        BottomNavigationBarItem(icon: Icon(Icons.details_outlined, color: Colors.black45,),label: "Đơn Hàng"),
        BottomNavigationBarItem(icon: Icon(Icons.store_outlined,color: Colors.black45),label: "Cửa hàng"),
        BottomNavigationBarItem(icon: Icon(Icons.discount,color: Colors.black45),label: "Discount"),
      ],
      onTap: onTapNavigationBar,);
  }
  void onTapNavigationBar(int value) {
    switch(NavigationPages.values[value]){

      case NavigationPages.admin_products:
        _changePages(value);
        break;
      case NavigationPages.admin_orderDetail:
        _changePages(value);
        break;
      case NavigationPages.admin_store:
        _changePages(value);
        break;
      case NavigationPages.admin_discount:
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

  admin_products,
  admin_orderDetail,
  admin_store,
  admin_discount

}

