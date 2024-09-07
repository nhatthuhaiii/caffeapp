import 'package:caffeapp/provider/detail_drink.dart';
import 'package:caffeapp/provider/getData.dart';
import 'package:caffeapp/provider/user_provider.dart';
import 'package:caffeapp/ui/main_screen/Screen_Carts/singleitems..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/cart.dart';
import '../../../src/cafe.dart';
import '../../../src/detail.dart';
import '../Screen_Login/signintabs.dart';

class favorite_Screen extends StatefulWidget {
  const favorite_Screen({super.key});

  @override
  State<favorite_Screen> createState() => _favorite_ScreenState();
}

class _favorite_ScreenState extends State<favorite_Screen> {
  //late Set<String> favoriteList;
  late List<Caffe> lst;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final lstFvProvider = Provider.of<DetailDrinkProvider>(context, listen: false);
    lstFvProvider.fetchProductsByAccount(context.read<user_provider>().userinfo!.userName);
    lst = context.read<getData>().listcaffe;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Favorite"),centerTitle: true,
        elevation: 3.0,
        shadowColor: Colors.black87.withOpacity(0.6 ),

      ),
      body:

      Selector<DetailDrinkProvider, List<String>>(
        builder: (BuildContext context, List<String> value, Widget? child) {
          return SingleChildScrollView(
            child:
            value.length ==0 ? Center(child: Text("Bạn chưa có sản phẩm yêu thích nào"),):
            Column(
              children: [


                for(int i=0;i<lst.length;i++)
                  if (value.contains(lst[i].ten))
                    InkWell(
                      onTap: () {
                        final  isfv = value.contains(lst[i].ten);
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return FractionallySizedBox(
                                heightFactor: 0.9,
                                child: singleitems(
                                  data: lst[i],
                                  fv: isfv,
                                ),
                              );
                            });
                      },
                      child: Container(
                        //padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                            left: 12, top: 10, right: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellowAccent.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white12,
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(
                                  left: 8, top: 8, bottom: 8),
                              child: Image.network(
                                "${lst[i].url}",
                                height: 90,
                                width: 90,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset("images/brand_logo2.jpg",height: 90,width: 90,);
                                }
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                      EdgeInsets.only(bottom: 10),
                                      child: Text("${lst[i].ten}"),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                              "${lst[i].gia}" +
                                                  ".000VNĐ"),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            if(context.read<user_provider>().userinfo == null){
                                              showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>FractionallySizedBox(
                                                heightFactor: 0.9,
                                                child: singinTabs(),
                                              ) );
                                              return;

                                            }
                                            detail a = detail(lst[i], 1,"M");
                                            context.read<cart>().addItems(a);


                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            margin: EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(20)),
                                            child: Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

              ],
            ),
          );

        },

        selector: (BuildContext  context,  user_provider ) {
          return user_provider.lstfv;
        },

      ),
    ));
  }
}
