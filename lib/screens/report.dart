import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/API/reports_api.dart';
import 'package:store_manager/components/Forms/UpdateStoreModel.dart';
import 'package:store_manager/components/MyCard.dart';
import 'package:store_manager/components/SideBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_manager/models/stores.dart';

class Report extends StatefulWidget {
  final Store data;
  const Report({super.key, required this.data});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final SidebarXController controller = SidebarXController(
    selectedIndex: 0,
  );

  double? uae_curr;
  int total_sales = 0;
  int total_store = 0;
  int sdg_amount = 0;
  double uae_amount = 0.0;
  int sdg_profit = 0;
  double uae_profit = 0;
  bool isLoading = false;
  // List<Store> items = [];

  @override
  void initState() {
    //set uae cuurency from prefrence
    _loadUAECurr();
    //--
    homeReport(widget.data.name);
    // getItems();
    super.initState();
  }

//shared prefrence for the exchange price of uae cuurency
  Future _loadUAECurr() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      uae_curr = prefs.getDouble("uae_curr") ?? 0;
    });
  }

//server function
  Future homeReport(String name) async {
    Map data = {};
    data['item_name'] = name;
    final response = await ReportApi.homeReports(data);

    if (response.statusCode == 200) {
      setState(() {
        total_sales = response.data['total_sales'];
        total_store = response.data['total_store'];
        sdg_amount = response.data['sdg_amount'];
        uae_amount = total_store * 1090;
        sdg_profit = response.data['sdg_profit'];
        uae_profit = response.data['sdg_profit'] / uae_curr!;
      });
    }
  }

  // Future getItems() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final response = await StoreApi.getItems();
  //   setState(() {
  //     isLoading = false;
  //   });

  //   if (response.statusCode == 200) {
  //     //using forEach for loop not (map) !!!!!!!!!!!!!!
  //     response.data.forEach((json) {
  //       setState(() {
  //         items.add(Store.fromJson(json));
  //       });
  //     });
  //   }
  // }

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
              SizedBox(
                height: 20,
              ),
              Text(
                'تقارير ${widget.data.name}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                  padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 50),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 194, 188, 188),
                      spreadRadius: 5,
                      blurRadius: 15,
                      blurStyle: BlurStyle.solid,
                    )
                  ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Container(
                          //   width: 280,
                          //   child: DropdownButtonFormField(
                          //     decoration: InputDecoration(labelText: 'اختر الصنف'),
                          //     value: widget.name,
                          //     items: items.map((item) {
                          //       return DropdownMenuItem(
                          //         child: Text('${item.name}'),
                          //         value: item.name,
                          //       );
                          //     }).toList(),
                          //     onChanged: (val) {
                          //       homeReport(val!);
                          //     },
                          //   ),
                          // ),
                          uae_curr != null
                              ? Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      child: TextFormField(
                                        initialValue: uae_curr.toString(),
                                        decoration: InputDecoration(
                                            labelText: "ريت الدرهم"),
                                        onChanged: (value) async {
                                          setState(() {
                                            uae_curr = double.parse(value);
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          final prefs = await SharedPreferences
                                              .getInstance();

                                          prefs.setDouble(
                                              'uae_curr', uae_curr!);

                                          Navigator.pushReplacementNamed(
                                              context, '/');
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.lightGreen,
                                            minimumSize: Size(80, 50)),
                                        child: Text(
                                          'تم',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: 15,
                                    )
                                  ],
                                )
                              : CircularProgressIndicator(),
                          UpdateStore(
                              title: widget.data.name, id: widget.data.id),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyCard(
                              width_num: 4,
                              height_num: 4.2,
                              title: total_store.toDouble(),
                              subtitle: 'اجمالي مخزون ${widget.data.name}'),
                          MyCard(
                            width_num: 4,
                            height_num: 4.2,
                            title: uae_amount,
                            subtitle: 'قيمة المخزون بالدرهم',
                            Icon: Icon(
                              Icons.monetization_on,
                              color: Colors.green,
                              size: 35,
                            ),
                          ),
                          MyCard(
                            width_num: 3,
                            height_num: 4.2,
                            title: sdg_amount.toDouble(),
                            subtitle: 'قيمة المخزون بالسوداني',
                            Icon: Icon(
                              Icons.monetization_on,
                              color: Colors.green,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 50,
              ),
              Row(children: [
                TextButton.icon(
                    onPressed: () {},
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.grey[300]),
                    icon: Icon(Icons.point_of_sale_sharp),
                    label: Text('مبيعات الشهر')),
              ]),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyCard(
                      width_num: 4,
                      height_num: 4.2,
                      title: total_sales.toDouble(),
                      subtitle: 'اجمالي مبيعات ${widget.data.name}'),
                  MyCard(
                      width_num: 4,
                      height_num: 4.2,
                      title: uae_profit,
                      subtitle: 'ارباح الشهر بالدرهم'),
                  Expanded(
                      child: MyCard(
                          width_num: 1,
                          height_num: 4.2,
                          title: sdg_profit.toDouble(),
                          subtitle: 'ارباح الشهر بالسوداني')),
                ],
              )
            ],
          ))
        ],
      )),
    );
  }
}
