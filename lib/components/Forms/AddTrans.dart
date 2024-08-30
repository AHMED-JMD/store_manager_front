import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/API/account_api.dart';
import 'package:store_manager/API/store_api.dart';
import 'package:store_manager/API/trans_api.dart';
import 'package:store_manager/components/Header.dart';
import 'package:store_manager/components/SideBar.dart';
import 'package:store_manager/models/account.dart';
import 'package:store_manager/models/stores.dart';

class AddTransact extends StatefulWidget {
  const AddTransact({super.key});

  @override
  State<AddTransact> createState() => _AddTransactState();
}

class _AddTransactState extends State<AddTransact> {
  SidebarXController controller = SidebarXController(selectedIndex: 1);
  final _formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final priceController = TextEditingController();
  final commentController = TextEditingController(text: '');

  String? type;
  String? item;
  String? emp;
  List<Store> items = [];
  List<Account> empolyees = [];
  bool isLoading = false;

  @override
  void initState() {
    getItems();
    getEmps();
    super.initState();
  }

  //server functions
  Future getItems() async {
    setState(() {
      isLoading = true;
    });
    final response = await StoreApi.getItems();
    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      //using forEach for loop not (map) !!!!!!!!!!!!!!
      response.data.forEach((json) {
        setState(() {
          items.add(Store.fromJson(json));
        });
      });
    }
  }

  Future getEmps() async {
    setState(() {
      isLoading = true;
    });
    final response = await AccountApi.getAll();
    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      response.data.forEach((json) {
        setState(() {
          empolyees.add(Account.fromJson(json));
        });
      });
    }
  }

  Future onSubmit(data) async {
    setState(() {
      isLoading = true;
    });

    final response = await TranApi.addTran(data);
    setState(() {
      isLoading = false;
    });
    if (response is DioException) {
      DioException err = response;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: Text(
          '${err.response!.data['message']}',
          style: TextStyle(fontSize: 19, color: Colors.white),
        )),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: Text(
          'تمت الاضافة بنجاح',
          style: TextStyle(fontSize: 19, color: Colors.white),
        )),
        duration: Duration(milliseconds: 800),
        backgroundColor: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Row(
            children: [
              MySideBar(controller: controller),
              Expanded(
                  child: ListView(
                children: [
                  myHeader('معاملة جديدة'),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 150.0, right: 150, top: 60),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isLoading)
                            Center(
                                child: Container(
                                    color: Colors.grey[200],
                                    width: 300,
                                    height: 50,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.lightGreen,
                                    )))),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'نوع المعاملة',
                              icon: Icon(
                                Icons.type_specimen_outlined,
                                color: Color.fromRGBO(2, 48, 71, 1),
                              ),
                            ),
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                child: Text('بيع'),
                                value: 'بيع',
                              ),
                              DropdownMenuItem(
                                child: Text('شراء'),
                                value: 'شراء',
                              ),
                              DropdownMenuItem(
                                child: Text('منصرف'),
                                value: 'منصرف',
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                type = val;
                                type == 'منصرف'
                                    ? priceController.text = "1"
                                    : priceController.text = "";
                              });
                            },
                            validator: (val) {
                              if (val == null)
                                return 'الرجاء اختيار نوع المعاملة';
                              return null;
                            },
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            dropdownColor: Colors.lightGreen,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                labelText: 'الصنف',
                                icon: Icon(
                                  Icons.local_grocery_store,
                                  color: Color.fromRGBO(2, 48, 71, 1),
                                )),
                            items: items.map((item) {
                              return DropdownMenuItem(
                                child: Text('${item.name}'),
                                value: item.id,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                item = value;
                              });
                            },
                            validator: (val) {
                              if (val == null) return 'الرجاء اختيار الصنف';
                              return null;
                            },
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            dropdownColor: Colors.lightGreen,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          type == 'منصرف'
                              ? TextFormField(
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    labelText: 'الكمية',
                                    icon: Icon(
                                      Icons.list_alt,
                                      color: Color.fromRGBO(2, 48, 71, 1),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return 'الرجاء اختيار الكمية';
                                    return null;
                                  },
                                )
                              : Column(
                                  children: [
                                    TextFormField(
                                      controller: amountController,
                                      decoration: InputDecoration(
                                        labelText: 'الكمية',
                                        icon: Icon(
                                          Icons.list_alt,
                                          color: Color.fromRGBO(2, 48, 71, 1),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        if (val!.isEmpty)
                                          return 'الرجاء اختيار الكمية';
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: priceController,
                                      decoration: InputDecoration(
                                          labelText: 'السعر',
                                          icon: Icon(
                                            Icons.price_change,
                                            color: Color.fromRGBO(2, 48, 71, 1),
                                          )),
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        if (val!.isEmpty)
                                          return 'الرجاء اختيار الكمية';
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                labelText: 'المندوب',
                                icon: Icon(
                                  Icons.person_pin,
                                  color: Color.fromRGBO(2, 48, 71, 1),
                                )),
                            items: empolyees.map((emp) {
                              return DropdownMenuItem(
                                child: Text('${emp.name}'),
                                value: emp.id,
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                emp = val;
                              });
                            },
                            validator: (val) {
                              if (val == null) return 'الرجاء اختيار المندوب';
                              return null;
                            },
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                            dropdownColor: Colors.lightGreen,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: dateController,
                            decoration: InputDecoration(
                                labelText: 'التاريخ',
                                icon: Icon(
                                  Icons.date_range,
                                  color: Color.fromRGBO(2, 48, 71, 1),
                                )),
                            readOnly: true,
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(20100));

                              if (selectedDate != null) {
                                String formatted =
                                    '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';

                                setState(() {
                                  dateController.text = formatted;
                                });
                              }
                            },
                          ),
                          TextFormField(
                            controller: commentController,
                            decoration: InputDecoration(
                              labelText: 'التعليق',
                              icon: Icon(
                                Icons.comment,
                                color: Color.fromRGBO(2, 48, 71, 1),
                              ),
                            ),
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Map data = {};
                                  data['item_id'] = item;
                                  data['emp_id'] = emp;
                                  data['type'] = type;
                                  data['amount'] = amountController.text;
                                  data['price'] = priceController.text;
                                  data['date'] = dateController.text;
                                  data['comment'] = commentController.text;

                                  onSubmit(data);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 50),
                                backgroundColor: Colors.lightGreen,
                              ),
                              child: Text('اضافة',
                                  style: TextStyle(color: Colors.white)))
                        ],
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
