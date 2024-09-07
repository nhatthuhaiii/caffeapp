import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/user_provider.dart';
import '../../../../src/user.dart';

class option_person extends StatefulWidget {
  option_person({super.key, required this.data});

  user? data;

  @override
  State<option_person> createState() => _option_personState();
}

class _option_personState extends State<option_person> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.data?.name ?? "";
    _phoneController.text = widget.data?.phoneNumber ?? "";
    _passwordController.text = widget.data?.pass ?? "";
    print(widget.data!.userName);

  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text("Thông tin người dùng"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Center(
                    child: ClipOval(
                      child: Image.network(
                        "${context.read<user_provider>().userinfo!.url}",
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),
                  Text("Tên Khách Hàng"),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20,),
                  Text("Số Điện Thoại"),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),

                  SizedBox(height: 20,),
                  Text("Mật Khẩu"),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible, 
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Spacer(),
              InkWell(
                onTap: () async {
                  final userProvider = Provider.of<user_provider>(context, listen: false);

                  bool updateSuccess = await userProvider.updateUserInfo(
                      name: _nameController.text,
                      phoneNumber: _phoneController.text,
                      password: _passwordController.text
                  );

                  if (updateSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Cập nhật thành công!")),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Cập nhật không thành công!")),
                    );
                  }
                },
                child: Expanded(
                  child: Container(
                    height: 50,

                    decoration: BoxDecoration(
                      color: Colors.grey,


                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Center(child: Text("Cập nhật tài khoản",style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ),


              InkWell(
                onTap: () async {

                final item = context.read<user_provider>().userinfo!.userName;
                showDialog(context: context, builder: (context)=> AlertDialog(
                  title: Text("Hẹn gặp lạiii"),
                ));
                context.read<user_provider>().deleteUserByUsername(item);
                context.read<user_provider>().clear();
                },
                child: Expanded(
                  child: Container(
                    height: 50,

                    decoration: BoxDecoration(



                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Center(child: Text("xoá tài khoản",style: TextStyle(color: Colors.black),)),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
