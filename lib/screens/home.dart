import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/API/reports_api.dart';
import 'package:store_manager/API/store_api.dart';
import 'package:store_manager/components/MyCard.dart';
import 'package:store_manager/components/SideBar.dart';
import 'package:store_manager/models/stores.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SidebarXController controller = SidebarXController(
    selectedIndex: 0,
  );
  int total_store = 0;
  int sdg_amount = 0;
  double uae_amount = 0.0;
  bool isLoading = false;
  List<Store> items = [];

  @override
  void initState() {
    homeReport('الفلير');
    getItems();
    super.initState();
  }

//server function
  Future homeReport(String name) async {
    Map data = {};
    data['item_name'] = name;
    final response = await ReportApi.homeReports(data);

    if (response.statusCode == 200) {
      setState(() {
        total_store = response.data['total_store'];
        sdg_amount = total_store * 790000;
        uae_amount = total_store * 725;
      });
    }
  }

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
                height: 70,
              ),
              Row(
                children: [
                  Container(
                    width: 280,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'اختر الصنف'),
                      items: items.map((item) {
                        return DropdownMenuItem(
                          child: Text('${item.name}'),
                          value: item.name,
                        );
                      }).toList(),
                      onChanged: (val) {
                        homeReport(val!);
                      },
                    ),
                  )
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
                      subtitle: 'اجمالي مخزون الفلير'),
                  MyCard(
                    width_num: 4,
                    height_num: 4.2,
                    title: uae_amount.toDouble(),
                    subtitle: 'قيمة المخزون بالدرهم',
                    Icon: Icon(
                      Icons.monetization_on,
                      color: Colors.green,
                      size: 35,
                    ),
                  ),
                  Expanded(
                    child: MyCard(
                      width_num: 1,
                      height_num: 4.2,
                      title: sdg_amount.toDouble(),
                      subtitle: 'قيمة المخزون بالسوداني',
                      Icon: Icon(
                        Icons.monetization_on,
                        color: Colors.green,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
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
                  Expanded(
                      child: MyCard(
                          width_num: 1,
                          height_num: 4.2,
                          title: 1350114,
                          subtitle: 'ارباح الشهر بالسوداني')),
                  MyCard(
                      width_num: 4,
                      height_num: 4.2,
                      title: 2540,
                      subtitle: 'ارباح الشهر بالدرهم'),
                  MyCard(
                      width_num: 4,
                      height_num: 4.2,
                      title: 30,
                      subtitle: 'اجمالي مبيعات الفلير'),
                ],
              )
            ],
          ))
        ],
      )),
    );
  }
}
