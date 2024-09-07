import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../../provider/getData.dart';
import '../../../src/Discount.dart';
import 'package:caffeapp/ui/admin_screen/admin_function/firebase_Utils.dart';

class admin_discount_screen extends StatefulWidget {
  const admin_discount_screen({super.key});

  @override
  State<admin_discount_screen> createState() => _admin_discount_screenState();
}

class _admin_discount_screenState extends State<admin_discount_screen> {
  List<Discount> list = [];

  @override
  void initState() {
    super.initState();
    list = context.read<getData>().listdiscount;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orangeAccent,
          child: const Icon(Icons.add,color: Colors.white,),
          onPressed: () {
            final _nameController = TextEditingController();
            final _priceController = TextEditingController();
            final _countController = TextEditingController();

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Thêm mã giảm giá"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Tên mã'),
                      ),
                      TextField(
                        controller: _priceController,
                        decoration: const InputDecoration(labelText: 'Giá trị giảm (0.1 = 10%)'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _countController,
                        decoration: const InputDecoration(labelText: 'Số lượng'),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Hủy"),
                  ),
                  ElevatedButton(
                    onPressed: ()  async {
                        firebase_Utils.addDiscount(_nameController.text, double.parse(_priceController.text), int.parse(_countController.text));
                      Navigator.pop(context);

                      },

                    child: const Text("Thêm"),
                  ),
                ],
              ),
            );
          },
        ),
        body: Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Discount',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Selector<getData, List<Discount>>(
                  selector: (context, provider) => provider.listdiscount,
                  builder: (context, list, child) {
                    if (list.isEmpty) {
                      return const Center(child: Text("Không có mã giảm giá nào."));
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final discount = list[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Slidable(

                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  label: 'Xóa',
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  onPressed: (context) {
                                    firebase_Utils.deleteDiscountByName(list[index].name);

                                  },
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.local_offer, color: Colors.green),
                              title: Text(discount.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Giảm giá: ${(discount.discountPrice * 100).toStringAsFixed(0)} %"),
                                  // Text("Số lượng còn: ${discount.count}"), // Comment or remove if not needed
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
